import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:cron/cron.dart';
import 'package:path/path.dart' as p;

import 'exporter_interface.dart';
import 'ingester_contract.dart';
import 'package:telegram_client/db_isolated.dart';

class Exporter implements ExporterInterface {
  final Logger logger;
  final DbIsolated db;

  late final IngesterContract ingesterContract;

  final IpfsParams ipfsParams;

  String cronFormat;
  Schedule schedule;
  String tableDumpPath;

  final _cron = Cron();

  static const tableNames = ['chat', 'message', 'user'];
  static const tableNamesUploadFull = ['chat'];

  static const String fileExtTypeData = 'json_lines';
  static const String fileExtTypeMeta = 'json_lines';
  static const String fileExtTypeHash = 'hash';

  static const int ipfsRequestRetryCountMax = 5;
  static const int ipfsRequestRetryDelaySeconds = 30;
  static const int ipfsRequestTimeoutSeconds = 60;

  bool _exportInProgress = false;

  Exporter(
      this.logger,
      this.db,
      this.cronFormat,
      this.schedule,
      this.tableDumpPath,
      this.ipfsParams,
      IngesterContractParams ingesterContractParams) {
    ingesterContract = IngesterContract(
      logger,
      ingesterContractParams,
    );
    logger.info('scheduled export to IPFS at $cronFormat.');
    _cron.schedule(schedule, _export);
  }

  Future<void> _export() async {
    if (_exportInProgress) return;
    _exportInProgress = true;

    final client = http.Client();
    final ipfsUri = _buildIpfsUri('/api/v0/add');
    for (final tableName in tableNames)
      await _exportTable(client, ipfsUri, tableName);
    client.close();

    final hashes = await db.selectMetaFileHahes();
    if (hashes.chat != null && hashes.message != null && hashes.user != null) {
      await ingesterContract.writeHashes(
          hashes.chat!, hashes.message!, hashes.user!);
    }

    _exportInProgress = false;
  }

  Future<void> _exportTable(
      http.Client client, Uri ipfsUri, String tableName) async {
    await _exportTableData(client, ipfsUri, tableName);
    await _exportTableMeta(client, ipfsUri, tableName);
  }

  Future<void> _exportTableData(
      http.Client client, Uri ipfsUri, String tableName) async {
    var fileName = p.joinAll([tableDumpPath, '$tableName.$fileExtTypeData']);
    final fromId = tableNamesUploadFull.contains(tableName) ? 0 : null;

    final recordsCount = await db.exportData(tableName, fileName, fromId);
    logger.info('exported $recordsCount data records for $tableName.');

    if (recordsCount == 0) return;

    var fileHash = await _ipfsAdd(client, ipfsUri, tableName, fileName);
    if (fileHash == null) return;
    logger.info('uploaded $tableName data records with hash $fileHash.');

    await db.insertIpfsHash(tableName, fileHash);
  }

  Future<void> _exportTableMeta(
      http.Client client, Uri ipfsUri, String tableName) async {
    var fileName =
        p.joinAll([tableDumpPath, '$tableName.meta.$fileExtTypeData']);

    final recordsCount = await db.exportMeta(tableName, fileName);
    logger.info('exported $recordsCount meta records for $tableName.');

    if (recordsCount == 0) return;

    var fileHash = await _ipfsAdd(client, ipfsUri, tableName, fileName);
    if (fileHash == null) return;
    logger.info('uploaded $tableName meta records with hash $fileHash.');

    await db.updateMetaFileHash(tableName, fileHash);
  }

  Uri _buildIpfsUri(
    String ipfsUriPath, [
    Map<String, dynamic>? queryParameters,
  ]) {
    final authority = '${ipfsParams.ipfsHost}:${ipfsParams.ipfsPort}';
    if (ipfsParams.ipfsScheme == 'https') {
      return Uri.https(authority, ipfsUriPath, queryParameters);
    } else {
      return Uri.http(authority, ipfsUriPath, queryParameters);
    }
  }

  _ipfsRequestAddAuth(http.BaseRequest request) {
    if (ipfsParams.ipfsUsername != null && ipfsParams.ipfsPassword != null) {
      final auth = '${ipfsParams.ipfsUsername}:${ipfsParams.ipfsPassword}';
      final basicAuth = base64.encode(utf8.encode(auth));
      request.headers['Authorization'] = 'Basic $basicAuth';
    }
    return request;
  }

  Future<String?> _ipfsAdd(http.Client httpClient, Uri ipfsUri,
      String tableName, String fileName) async {
    final responseBody =
        await _ipfsAddRetry(httpClient, ipfsUri, tableName, fileName);
    if (responseBody == null) return null;

    var responseBodyDecoded;
    try {
      responseBodyDecoded = jsonDecode(responseBody);
    } on Object catch (ex) {
      logger.warning(ex);
      return null;
    }

    if (responseBodyDecoded is! Map) {
      logger.warning('ipfs add error: '
          'reponse body is not a Map '
          'body=${responseBody}.');
      return null;
    }

    if (!responseBodyDecoded.containsKey('Hash')) {
      logger.warning('ipfs add error: '
          'reponse body without the Hash key '
          'body=${responseBody}.');
      return null;
    }

    return responseBodyDecoded['Hash'];
  }

  Future<String?> _ipfsAddRetry(http.Client httpClient, Uri ipfsUri,
      String dataName, String fileName) async {
    var ipfsRequestRetryCountIndex = 1;

    while (ipfsRequestRetryCountIndex <= ipfsRequestRetryCountMax) {
      var request = http.MultipartRequest('POST', ipfsUri);
      request = _ipfsRequestAddAuth(request);

      var multipartFile = await http.MultipartFile.fromPath('data', fileName);
      request.files.add(multipartFile);

      var responseIpfsAdd;
      try {
        responseIpfsAdd = await httpClient
            .send(request)
            .timeout(const Duration(seconds: ipfsRequestTimeoutSeconds));
      } on Object catch (ex) {
        logger.warning(ex);

        logger.info('ipfs add: '
            'retrying in $ipfsRequestRetryDelaySeconds seconds.');
        await Future.delayed(Duration(seconds: ipfsRequestRetryDelaySeconds));
        ipfsRequestRetryCountIndex += 1;
        continue;
      }

      var responseBody = await responseIpfsAdd.stream.bytesToString();
      if (responseIpfsAdd.statusCode == 200) {
        return responseBody;
      }

      logger.warning('ipfs add error: '
          'code=${responseIpfsAdd.statusCode} '
          'body=${responseBody}.');

      logger.info('ipfs add: '
          'retrying in $ipfsRequestRetryDelaySeconds seconds.');
      await Future.delayed(Duration(seconds: ipfsRequestRetryDelaySeconds));

      ipfsRequestRetryCountIndex += 1;
    }

    return null;
  }
}

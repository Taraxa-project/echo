import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:telegram_client/db_interface.dart';
import 'package:telegram_client/db_sql.dart';

import 'exporter_interface.dart';
import 'ingester_contract.dart';
import 'package:telegram_client/db_isolated.dart';

class Exporter implements ExporterInterface {
  final Logger logger;
  final DbIsolated db;

  late final IngesterContract ingesterContract;

  final IpfsParams ipfsParams;

  String tableDumpPath;

  static const tableNames = ['chat_read', 'chat', 'message', 'user'];
  static const tableNamesUploadFull = ['chat'];

  static const int ipfsRequestRetryCountMax = 5;
  static const int ipfsRequestRetryDelaySeconds = 30;
  static const int ipfsRequestTimeoutSeconds = 60;

  bool _exportInProgress = false;

  Exporter(this.logger, this.db, this.tableDumpPath, this.ipfsParams,
      IngesterContractParams ingesterContractParams) {
    ingesterContract = IngesterContract(
      logger,
      ingesterContractParams,
    );
  }

  Future<void> _export() async {
    if (_exportInProgress) return;
    _exportInProgress = true;

    await db.exportPrepare();

    // final client = http.Client();
    // final ipfsUri = _buildIpfsUri('/api/v0/add');

    // await _exportChatsRead(client, ipfsUri);
    // await _exportChat(client, ipfsUri);
    // await _exportMessage(client, ipfsUri);
    // await _exportUser(client, ipfsUri);

    // client.close();

    // final hashes = await db.selectMetaFileHahes();
    // if (hashes.chat != null && hashes.message != null && hashes.user != null) {
    //   await ingesterContract.writeHashes(
    //       hashes.chat!, hashes.message!, hashes.user!);
    // }

    _exportInProgress = false;
  }

  Future<void> _exportChatsRead(http.Client client, Uri ipfsUri) async {
    final dateTimeFrom =
        DateTime.now().toUtc().subtract(const Duration(days: 14));

    final chats = await db.select(SqlChat.selectAll);
    for (final chat in chats) {
      if (chat['id'] == null) continue;
      await _exportChatRead(client, ipfsUri,
          ExportTypeChatRead(tableDumpPath, chat['id'], dateTimeFrom));
    }
  }

  Future<void> _exportChatRead(
      http.Client client, Uri ipfsUri, ExportType exportType) async {
    await _exportData(client, ipfsUri, exportType);
  }

  Future<void> _exportChat(http.Client client, Uri ipfsUri) async {
    await _exportDataMeta(client, ipfsUri, ExportTypeChat(tableDumpPath));
  }

  Future<void> _exportMessage(http.Client client, Uri ipfsUri) async {
    await _exportDataMeta(client, ipfsUri, ExportTypeMessage(tableDumpPath));
  }

  Future<void> _exportUser(http.Client client, Uri ipfsUri) async {
    await _exportDataMeta(client, ipfsUri, ExportTypeUser(tableDumpPath));
  }

  Future<void> _exportDataMeta(
      http.Client client, Uri ipfsUri, ExportType exportType) async {
    await _exportData(client, ipfsUri, exportType);
    await _exportMeta(client, ipfsUri, exportType);
  }

  Future<void> _exportData(
      http.Client client, Uri ipfsUri, ExportType exportType) async {
    while (true) {
      final exportResult = await db.exportData(exportType);
      logger.info('exported ${exportResult.recordCount} data records '
          'for ${exportType.dataType}.');

      if (exportResult.recordCount == 0) return;

      final fileHash = await _ipfsAdd(client, ipfsUri, exportType.dataType,
          exportType.fileNameFullPathData);
      if (fileHash == null) return;
      logger.info(
          'uploaded ${exportType.dataType} data records with hash $fileHash.');

      await db.insertIpfsHash(exportResult, fileHash);

      if (exportResult.recordCount < exportRecordLimit) return;
      if (tableNamesUploadFull.contains(exportType.dataType)) return;
    }
  }

  Future<void> _exportMeta(
      http.Client client, Uri ipfsUri, ExportType exportType) async {
    final recordsCount = await db.exportMeta(exportType);
    logger.info(
        'exported $recordsCount meta records for ${exportType.dataType}.');

    if (recordsCount == 0) return;

    var fileHash = await _ipfsAdd(
        client, ipfsUri, exportType.dataType, exportType.fileNameFullPathMeta);
    if (fileHash == null) return;
    logger.info(
        'uploaded ${exportType.dataType} meta records with hash $fileHash.');

    await db.updateMetaFileHash(exportType.dataType, fileHash);
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

  @override
  Future<void> export() async {
    await _export();
  }
}

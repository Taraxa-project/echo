import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

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
  static const int ipfsRequestRetryDelaySeconds = 10;
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

    final httpClient = http.Client();
    final fileName = p.join(tableDumpPath, 'export.json_lines');

    while (true) {
      final exportResult = await db.exportNextData(fileName);
      if (exportResult == null) break;

      final ipfsUriAdd = _buildIpfsUri('/api/v0/add');
      final cid = await _ipfsAdd(httpClient, ipfsUriAdd, fileName);
      if (cid == null) return;

      final type = exportResult.type;
      logger.info('uploaded $type data records with hash $cid.');

      await db.updateDataCid(exportResult.rowid, cid);

      if (exportResult.cid_old != null && exportResult.cid_old != cid) {
        final ipfsUriUnpin =
            _buildIpfsUri('/api/v0/pin/rm', {'arg': exportResult.cid_old!});
        await _ipfsUnpin(httpClient, ipfsUriUnpin);
        logger.info('unpinned $type data hash ${exportResult.cid_old!}.');
      }

      await Future.delayed(const Duration(seconds: 1));
    }

    while (true) {
      final exportResult = await db.exportNextMeta(fileName);
      if (exportResult == null) break;

      final ipfsUriAdd = _buildIpfsUri('/api/v0/add');
      final cid = await _ipfsAdd(httpClient, ipfsUriAdd, fileName);
      if (cid == null) return;

      final type = exportResult.type;
      logger.info('uploaded $type meta records with hash $cid.');

      await db.updateMetaCid(exportResult.rowid, cid);

      if (exportResult.cid_old != null && exportResult.cid_old != cid) {
        final ipfsUriUnpin =
            _buildIpfsUri('/api/v0/pin/rm', {'arg': exportResult.cid_old!});
        await _ipfsUnpin(httpClient, ipfsUriUnpin);
        logger.info('unpinned $type meta hash ${exportResult.cid_old!}.');
      }

      await Future.delayed(const Duration(seconds: 1));
    }

    httpClient.close();

    final hashes = await db.selectMetaFileHahes();
    if (hashes.chat != null && hashes.message != null && hashes.user != null) {
      await ingesterContract.writeHashes(
          hashes.chat!, hashes.message!, hashes.user!);
    }

    _exportInProgress = false;
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

  Future<String?> _ipfsAdd(
      http.Client httpClient, Uri ipfsUri, String fileName) async {
    final responseBody = await _ipfsAddRetry(httpClient, ipfsUri, fileName);
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

  Future<String?> _ipfsAddRetry(
      http.Client httpClient, Uri ipfsUri, String fileName) async {
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

  Future<void> _ipfsUnpin(http.Client httpClient, Uri ipfsUri) async {
    final responseBody = await _ipfsUnpinRetry(httpClient, ipfsUri);
    if (responseBody == null || responseBody.isEmpty) return null;

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
  }

  Future<String?> _ipfsUnpinRetry(http.Client httpClient, Uri ipfsUri) async {
    var ipfsRequestRetryCountIndex = 1;

    while (ipfsRequestRetryCountIndex <= ipfsRequestRetryCountMax) {
      var request = http.Request('POST', ipfsUri);
      request = _ipfsRequestAddAuth(request);

      var response;
      try {
        response = await httpClient
            .send(request)
            .timeout(const Duration(seconds: ipfsRequestTimeoutSeconds));
      } on Object catch (ex) {
        logger.warning(ex);

        logger.info('ipfs unpin: '
            'retrying in $ipfsRequestRetryDelaySeconds seconds.');
        await Future.delayed(Duration(seconds: ipfsRequestRetryDelaySeconds));
        ipfsRequestRetryCountIndex += 1;
        continue;
      }

      var responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return responseBody;
      }

      logger.warning('ipfs unpin error: '
          'code=${response.statusCode} '
          'body=${responseBody}.');

      logger.info('ipfs unpin: '
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

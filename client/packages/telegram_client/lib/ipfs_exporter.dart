import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:cron/cron.dart';
import 'package:path/path.dart' as p;

import 'isolate.dart';
import 'db.dart';
import 'ingester_contract.dart';

class IpfsExporter extends Isolated {
  SendPort? logSendPort;

  final SendPort dbSendPort;
  final SendPort ingesterContractSendPort;

  String cronFormat;
  Schedule schedule;
  String tableDumpPath;

  String ipfsScheme;
  String ipfsHost;
  String ipfsPort;
  String? ipfsUsername;
  String? ipfsPassword;

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

  IpfsExporter({
    Level? super.logLevel,
    this.logSendPort,
    required this.dbSendPort,
    required this.ingesterContractSendPort,
    required this.cronFormat,
    required this.schedule,
    required this.tableDumpPath,
    required this.ipfsScheme,
    required this.ipfsHost,
    required this.ipfsPort,
    this.ipfsUsername,
    this.ipfsPassword,
  }) {
    logger.onRecord.listen((logRecord) {
      logSendPort?.send(logRecord);
    });
  }

  void init(SendPort parentSendPort) {
    super.init(parentSendPort);
    _initSchedule();
  }

  void initDispatch() {
    receivePortBroadcast.listen((message) {
      if (message is IsolateMsgRequestExit) {
        logger.fine('exiting...');
        exit(message.replySendPort);
      }
    });
  }

  void _initSchedule() {
    logger.info('scheduled export to IPFS at: $cronFormat');
    _cron.schedule(schedule, _export);
  }

  Future<void> exit(SendPort? replySendPort) async {
    await _cron.close();

    replySendPort?.send(IsolateMsgResponseExit());

    await Future.delayed(const Duration(milliseconds: 10));

    receivePort.close();
    Isolate.exit();
  }

  Future<void> _export() async {
    if (_exportInProgress) return;

    _exportInProgress = true;

    final client = http.Client();
    final ipfsUri = _buildIpfsUri('/api/v0/add');

    for (var tableName in tableNames) {
      var fileNameData = p.joinAll([
        tableDumpPath,
        '$tableName.$fileExtTypeData',
      ]);
      dbSendPort.send(
        DbMsgRequestDumpData(
            replySendPort: receivePort.sendPort,
            tableName: tableName,
            fileName: fileNameData,
            fromId: tableNamesUploadFull.contains(tableName) ? 0 : null),
      );
      var responseDumpData = await receivePortBroadcast
          .where((event) => event is DbMsgResponseDumpData)
          .first;
      if (responseDumpData.exception != null) {
        logger.severe(responseDumpData.exception!);
        continue;
      }
      if (responseDumpData.count == 0) {
        continue;
      }

      logger.info('uploading $tableName to IPFS...');

      var fileHashData =
          await _ipfsAdd(client, ipfsUri, tableName, fileNameData);
      if (fileHashData == null) {
        continue;
      }
      logger.info('uploading $tableName to IPFS... done. Hash: $fileHashData.');

      dbSendPort.send(DbMsgRequestUploadDataSucces(
        replySendPort: receivePort.sendPort,
        tableName: tableName,
        file_hash: fileHashData,
      ));
      var responseUploadData = await receivePortBroadcast
          .where((event) => event is DbMsgResponseUploadDataSucces)
          .first;

      if (responseUploadData.exception != null) {
        logger.severe(responseDumpData.exception!);
        continue;
      }

      var fileNameMeta = p.joinAll([
        tableDumpPath,
        '$tableName.meta.$fileExtTypeData',
      ]);
      dbSendPort.send(DbMsgRequestDumpMeta(
        replySendPort: receivePort.sendPort,
        tableName: tableName,
        fileName: fileNameMeta,
      ));
      var responseDumpMeta = await receivePortBroadcast
          .where((event) => event is DbMsgResponseDumpMeta)
          .first;
      if (responseDumpMeta.exception != null) {
        logger.severe(responseDumpMeta.exception!);
        continue;
      }
      if (responseDumpMeta.count == 0) {
        continue;
      }

      logger.info('uploading $tableName ipfs file hashes to IPFS...');

      var fileHashMeta =
          await _ipfsAdd(client, ipfsUri, tableName, fileNameMeta);
      if (fileHashMeta == null) {
        continue;
      }
      logger.info('uploading $tableName ipfs file hashes to IPFS... done.'
          ' Hash: $fileHashMeta.');

      dbSendPort.send(DbMsgRequestUploadMetaSucces(
        replySendPort: receivePort.sendPort,
        tableName: tableName,
        file_hash: fileHashMeta,
      ));
      var responseUploadMeta = await receivePortBroadcast
          .where((event) => event is DbMsgResponseUploadMetaSucces)
          .first;
      if (responseUploadMeta.exception != null) {
        logger.severe(responseDumpData.exception!);
        continue;
      }
    }

    client.close();

    logger.info('writing hashes to smart contract...');
    await _writeHashes();
    logger.info('writing hashes to smart contract... done.');

    _exportInProgress = false;
  }

  Future<void> _writeHashes() async {
    ingesterContractSendPort.send(IngesterContractMsgRequestWriteHashes(
      replySendPort: receivePort.sendPort,
    ));
    await receivePortBroadcast
        .where((event) => event is IngesterContractMsgResponseWriteHashes)
        .first;
  }

  Uri _buildIpfsUri(
    String ipfsUriPath, [
    Map<String, dynamic>? queryParameters,
  ]) {
    if (ipfsScheme == 'https') {
      return Uri.https('$ipfsHost:$ipfsPort', ipfsUriPath, queryParameters);
    } else {
      return Uri.http('$ipfsHost:$ipfsPort', ipfsUriPath, queryParameters);
    }
  }

  _ipfsRequestAddAuth(http.BaseRequest request) {
    if (ipfsUsername != null && ipfsPassword != null) {
      var basicAuth = base64.encode(utf8.encode('$ipfsUsername:$ipfsPassword'));
      request.headers['Authorization'] = 'Basic $basicAuth';
    }
    return request;
  }

  Future<String?> _ipfsAdd(
    http.Client httpClient,
    Uri ipfsUri,
    String tableName,
    String fileName,
  ) async {
    var responseBodyIpfsAdd = await _ipfsAddRetry(
      httpClient,
      ipfsUri,
      tableName,
      fileName,
    );
    if (responseBodyIpfsAdd == null) {
      return null;
    }

    var responseBodyIpfsAddDecoded;
    try {
      responseBodyIpfsAddDecoded = jsonDecode(responseBodyIpfsAdd);
    } on FormatException catch (ex) {
      logger.warning(ex);
      return null;
    }

    if (responseBodyIpfsAddDecoded is! Map) {
      logger.warning('ipfs add error: '
          'reponse body is not a Map '
          'body=${responseBodyIpfsAdd}.');
      return null;
    }

    if (!responseBodyIpfsAddDecoded.containsKey('Hash')) {
      logger.warning('ipfs add error: '
          'reponse body without the Hash key '
          'body=${responseBodyIpfsAdd}.');
      return null;
    }

    return responseBodyIpfsAddDecoded['Hash'];
  }

  Future<String?> _ipfsAddRetry(
    http.Client httpClient,
    Uri ipfsUri,
    String dataName,
    String fileName,
  ) async {
    var ipfsRequestRetryCountIndex = 1;

    while (ipfsRequestRetryCountIndex <= ipfsRequestRetryCountMax) {
      var requestIpfsAdd = http.MultipartRequest(
        'POST',
        ipfsUri,
      );
      requestIpfsAdd = _ipfsRequestAddAuth(requestIpfsAdd);

      var multipartFile = await http.MultipartFile.fromPath('data', fileName);
      requestIpfsAdd.files.add(multipartFile);

      logger.info('uploading $dataName to IPFS...'
          ' Retry $ipfsRequestRetryCountIndex/$ipfsRequestRetryCountMax.');

      var responseIpfsAdd;
      try {
        responseIpfsAdd = await httpClient
            .send(requestIpfsAdd)
            .timeout(const Duration(seconds: ipfsRequestTimeoutSeconds));
      } on Exception catch (ex) {
        logger.warning(ex);
        logger.info('ipfs add: '
            'retrying in $ipfsRequestRetryDelaySeconds seconds.');
        await Future.delayed(Duration(seconds: ipfsRequestRetryDelaySeconds));
        ipfsRequestRetryCountIndex += 1;
        continue;
      }

      var responseBodyIpfsAdd = await responseIpfsAdd.stream.bytesToString();

      if (responseIpfsAdd.statusCode == 200) {
        return responseBodyIpfsAdd;
      }

      logger.warning('ipfs add error: '
          'code=${responseIpfsAdd.statusCode} '
          'body=${responseBodyIpfsAdd}.');

      logger.info('ipfs add: '
          'retrying in $ipfsRequestRetryDelaySeconds seconds.');
      await Future.delayed(Duration(seconds: ipfsRequestRetryDelaySeconds));

      ipfsRequestRetryCountIndex += 1;
    }

    return null;
  }
}

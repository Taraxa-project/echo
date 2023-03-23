import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:cron/cron.dart';
import 'package:path/path.dart' as p;

import 'isolate.dart';
import 'db.dart';

class IpfsExporter extends Isolated {
  SendPort? logSendPort;

  final SendPort dbSendPort;

  String cronFormat;
  Schedule schedule;
  String tableDumpPath;

  String ipfsScheme;
  String ipfsHost;
  String ipfsPort;
  String? ipfsUsername;
  String? ipfsPassword;

  final _cron = Cron();

  static const dataNames = ['chat', 'message', 'user'];
  static const dataNamesTruncate = ['chat'];

  static const ipfsUriPathFileWrite = '/api/v0/files/write';
  static const ipfsUriPathFileStat = '/api/v0/files/stat';

  static const String fileExtData = 'json_lines';
  static const String fileExtHash = 'hash';

  static const int ipfsRequestRetryCountMax = 5;
  static const int ipfsRequestRetryDelaySeconds = 30;
  static const int ipfsRequestTimeoutSeconds = 60;

  String? appId;

  bool _exportInProgress = false;

  IpfsExporter({
    this.logSendPort,
    required this.dbSendPort,
    required Level logLevel,
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
    appId = await _readAppId();
    if (appId != null) {
      await _writeFilesLocally();
      await _writeFilesToIpfs();
    }
    _exportInProgress = false;
  }

  Future<String?> _readAppId() async {
    logger.info('reading app id...');

    dbSendPort.send(DbMsgRequestAppId(replySendPort: receivePort.sendPort));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseAppId)
        .first;

    if (response.exception != null) {
      logger.severe(response.exception!);
    } else {
      logger.info('reading app id... done.');
    }
    return response.appId;
  }

  Future<void> _writeFilesLocally() async {
    logger.info('writing files locally...');

    dbSendPort.send(DbMsgRequestDumpTables(
      replySendPort: receivePort.sendPort,
      dumpPath: tableDumpPath,
      dumpExt: fileExtData,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseDumpTables)
        .first;

    if (response.exception != null) {
      logger.severe(response.exception!);
    } else {
      logger.info('writing files locally... done.');
    }
  }

  Future<void> _writeFilesToIpfs() async {
    logger.info('uploading files to ipfs...');

    final client = http.Client();

    for (var dataName in dataNames) {
      logger.info('writing $dataName to IPFS...');

      Map<String, dynamic> ipfsQueryParameters = {};
      if (dataNamesTruncate.contains(dataName)) {
        ipfsQueryParameters['truncate'] = true;
      }
      var _ipfsFileWriteResult = await _ipfsFileWriteRetry(client, dataName);
      if (_ipfsFileWriteResult == null) {
        continue;
      }
      logger.info('writing $dataName to IPFS... done.');

      logger.info('reading stats for $dataName from IPFS...');
      var hash = await _ipfsFileStatRetry(client, dataName);
      if (hash == null) {
        continue;
      }
      logger.info('reading stats for $dataName from IPFS... done.'
          ' Hash: $hash.');

      logger.info('writing hash to $dataName.$fileExtHash...');
      await _writeHash(dataName, hash);
      logger.info('wroting hash to $dataName.$fileExtHash... done.');
    }

    client.close();

    logger.info('uploading files to ipfs... done.');
  }

  Future<bool?> _ipfsFileWriteRetry(
      http.Client httpClient, String dataName) async {
    var fileName = _fileName(dataName);

    Map<String, dynamic> ipfsQueryParameters = {'arg': fileName};
    if (dataNamesTruncate.contains(dataName)) {
      ipfsQueryParameters['truncate'] = true;
    }
    var ipfsUri = _buildIpfsUri(ipfsUriPathFileWrite, ipfsQueryParameters);

    var ipfsRequestRetryCountIndex = 1;
    while (ipfsRequestRetryCountIndex <= ipfsRequestRetryCountMax) {
      var logRetryIndex =
          '$ipfsRequestRetryCountIndex / $ipfsRequestRetryCountMax';

      var ipfsRequest = http.MultipartRequest('POST', ipfsUri);
      ipfsRequest = _ipfsRequestAddAuth(ipfsRequest);

      var multipartFile = await http.MultipartFile.fromPath(
        'data',
        p.join(tableDumpPath, fileName),
      );
      ipfsRequest.files.add(multipartFile);

      logger.info('[$logRetryIndex] ipfs write $dataName...');

      var ipfsResponse;
      try {
        ipfsResponse = await httpClient
            .send(ipfsRequest)
            .timeout(const Duration(seconds: ipfsRequestTimeoutSeconds));
      } on Exception catch (ex) {
        logger.warning(ex);

        logger.info('[$logRetryIndex] ipfs write $dataName...'
            ' retrying in $ipfsRequestRetryDelaySeconds seconds.');
        await Future.delayed(Duration(seconds: ipfsRequestRetryDelaySeconds));
        ipfsRequestRetryCountIndex += 1;
        continue;
      }

      var ipfsResponseBody = await ipfsResponse.stream.bytesToString();

      if (ipfsResponse.statusCode == 200) {
        logger.info('[$logRetryIndex] ipfs write $dataName... done.');
        return true;
      }

      logger.warning('[$logRetryIndex] ipfs write $dataName...'
          ' code=${ipfsResponse.statusCode} '
          ' body=${ipfsResponseBody}.');

      logger.info('[$logRetryIndex] ipfs write $dataName...'
          ' retrying in $ipfsRequestRetryDelaySeconds seconds.');
      await Future.delayed(Duration(seconds: ipfsRequestRetryDelaySeconds));

      ipfsRequestRetryCountIndex += 1;
    }

    return null;
  }

  Future<String?> _ipfsFileStatRetry(
      http.Client httpClient, String dataName) async {
    var ipfsUri = _buildIpfsUri(ipfsUriPathFileStat);

    var ipfsRequestRetryCountIndex = 1;

    while (ipfsRequestRetryCountIndex <= ipfsRequestRetryCountMax) {
      var logRetryIndex =
          '$ipfsRequestRetryCountIndex / $ipfsRequestRetryCountMax';

      var ipfsRequest = http.Request('POST', ipfsUri);
      ipfsRequest = _ipfsRequestAddAuth(ipfsRequest);

      logger.info('[$logRetryIndex] ipfs stat $dataName...');

      var ipfsResponse;
      try {
        ipfsResponse = await httpClient
            .send(ipfsRequest)
            .timeout(const Duration(seconds: ipfsRequestTimeoutSeconds));
      } on Exception catch (ex) {
        logger.warning(ex);

        logger.info('[$logRetryIndex] ipfs stat $dataName...'
            ' retrying in $ipfsRequestRetryDelaySeconds seconds.');
        await Future.delayed(Duration(seconds: ipfsRequestRetryDelaySeconds));
        ipfsRequestRetryCountIndex += 1;
        continue;
      }

      var ipfsResponseBody = await ipfsResponse.stream.bytesToString();

      if (ipfsResponse.statusCode == 200) {
        logger.info('[$logRetryIndex] ipfs stat $dataName... done.');
        return ipfsResponseBody['Hash'];
      }

      logger.warning('[$logRetryIndex] ipfs stat $dataName...'
          ' code=${ipfsResponse.statusCode}'
          ' body=${ipfsResponseBody}.');

      logger.info('[$logRetryIndex] ipfs stat $dataName...'
          ' retrying in $ipfsRequestRetryDelaySeconds seconds.');
      await Future.delayed(Duration(seconds: ipfsRequestRetryDelaySeconds));

      ipfsRequestRetryCountIndex += 1;
    }

    return null;
  }

  Future<void> _writeHash(
    String dataName,
    String hash,
  ) async {
    var fileHash = new File(p.join(tableDumpPath, '$dataName.$fileExtHash'));
    fileHash.createSync();

    final sink = fileHash.openWrite(mode: FileMode.write);
    sink.write(hash);
    sink.write('\n');

    await sink.flush();
    await sink.close();
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

  String _fileName(String dataName) {
    return '$dataName-$appId.$fileExtData';
  }
}

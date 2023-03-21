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

  static const String fileExtData = 'json_lines';
  static const String fileExtHash = 'hash';

  static const int ipfsRequestRetryCountMax = 5;
  static const int ipfsRequestRetryDelaySeconds = 30;

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
    _cron.close();

    replySendPort?.send(IsolateMsgResponseExit());

    await Future.delayed(const Duration(milliseconds: 10));

    receivePort.close();
    Isolate.exit();
  }

  Future<void> _export() async {
    if (_exportInProgress) return;

    _exportInProgress = true;
    await _writeFilesLocally();
    await _writeFilesToIpfs();
    _exportInProgress = false;
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

    var ipfsUri;
    if (ipfsScheme == 'https') {
      ipfsUri = Uri.https(
        '$ipfsHost:$ipfsPort',
        '/api/v0/add',
      );
    } else {
      ipfsUri = Uri.http(
        '$ipfsHost:$ipfsPort',
        '/api/v0/add',
      );
    }

    for (var dataName in ['chat', 'message', 'user']) {
      logger.info('uploading $dataName to IPFS...');

      var hash = await _ipfsAdd(client, ipfsUri, dataName);
      if (hash == null) {
        continue;
      }
      logger.info('uploading $dataName to IPFS... done. Hash: $hash.');

      logger.info('writing hash to $dataName.$fileExtHash...');
      await _writeHash(dataName, hash);
      logger.info('wroting hash to $dataName.$fileExtHash... done.');
    }

    client.close();

    logger.info('uploading files to ipfs... done.');
  }

  Future<String?> _ipfsAdd(
    http.Client httpClient,
    Uri ipfsUri,
    String dataName,
  ) async {
    var responseBodyIpfsAdd = await _ipfsAddRetry(
      httpClient,
      ipfsUri,
      dataName,
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
  ) async {
    var ipfsRequestRetryCountIndex = 1;

    while (ipfsRequestRetryCountIndex <= ipfsRequestRetryCountMax) {
      var requestIpfsAdd = http.MultipartRequest(
        'POST',
        ipfsUri,
      );

      if (ipfsUsername != null && ipfsPassword != null) {
        var basicAuth =
            base64.encode(utf8.encode('$ipfsUsername:$ipfsPassword'));
        requestIpfsAdd.headers['Authorization'] = 'Basic $basicAuth';
      }

      var multipartFile = await http.MultipartFile.fromPath(
        'data',
        p.join(tableDumpPath, '$dataName.$fileExtData'),
      );
      requestIpfsAdd.files.add(multipartFile);

      logger.info('uploading $dataName to IPFS...'
          ' Retry $ipfsRequestRetryCountIndex/$ipfsRequestRetryCountMax.');

      var responseIpfsAdd;
      try {
        responseIpfsAdd = await httpClient
            .send(requestIpfsAdd)
            .timeout(const Duration(seconds: 30));
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
}

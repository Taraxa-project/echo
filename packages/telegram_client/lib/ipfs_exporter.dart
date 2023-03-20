import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:cron/cron.dart';
import 'package:path/path.dart' as p;

import 'db.dart';

class IpfsExporter {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late SendPort isolateSendPort;

  final _logger = Logger('IpfsExporter');

  Future<void> spawn({
    required Level logLevel,
    required SendPort logSendPort,
    required SendPort dbSendPort,
    required String cronFormat,
    required Schedule schedule,
    required String tableDumpPath,
    required String ipfsScheme,
    required String ipfsHost,
    required String ipfsPort,
    String? ipfsUsername,
    String? ipfsPassword,
  }) async {
    _logger.level = logLevel;
    _logger.onRecord.listen((event) {
      logSendPort.send(event);
    });

    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();

    await Isolate.spawn(
      IpfsExporter._entryPoint,
      IpfsExporterIsolatedSpwanMessage(
        parentSendPort: _isolateReceivePort.sendPort,
        logSendPort: logSendPort,
        dbSendPort: dbSendPort,
        logLevel: _logger.level,
        cronFormat: cronFormat,
        schedule: schedule,
        tableDumpPath: tableDumpPath,
        ipfsScheme: ipfsScheme,
        ipfsHost: ipfsHost,
        ipfsPort: ipfsPort,
        ipfsUsername: ipfsUsername,
        ipfsPassword: ipfsPassword,
      ),
      debugName: runtimeType.toString(),
    );
    _logger.fine('spawned.');

    isolateSendPort = await _isolateReceivePortBroadcast.first;

    _logger.onRecord.listen((event) {
      isolateSendPort.send(event);
    });
  }

  static void _entryPoint(
      IpfsExporterIsolatedSpwanMessage initialSpawnMessage) {
    hierarchicalLoggingEnabled = true;

    final lgIsolated = IpfsExporterIsolated(
      parentSendPort: initialSpawnMessage.parentSendPort,
      logSendPort: initialSpawnMessage.logSendPort,
      dbSendPort: initialSpawnMessage.dbSendPort,
      logLevel: initialSpawnMessage.logLevel,
      cronFormat: initialSpawnMessage.cronFormat,
      schedule: initialSpawnMessage.schedule,
      tableDumpPath: initialSpawnMessage.tableDumpPath,
      ipfsScheme: initialSpawnMessage.ipfsScheme,
      ipfsHost: initialSpawnMessage.ipfsHost,
      ipfsPort: initialSpawnMessage.ipfsPort,
      ipfsUsername: initialSpawnMessage.ipfsUsername,
      ipfsPassword: initialSpawnMessage.ipfsPassword,
    );
    lgIsolated.init();

    lgIsolated._logger.fine('spawned.');
  }

  Future<void> exit() async {
    isolateSendPort.send(IpfsExporterRequestExit(
      replySendPort: _isolateReceivePort.sendPort,
    ));
    await _isolateReceivePortBroadcast
        .firstWhere((event) => event is IpfsExporterRequestExit);
    _isolateReceivePort.close();
  }
}

class IpfsExporterIsolatedSpwanMessage {
  final SendPort parentSendPort;
  final SendPort logSendPort;
  final SendPort dbSendPort;
  final Level logLevel;
  String cronFormat;
  final Schedule schedule;
  final String tableDumpPath;
  final String ipfsScheme;
  final String ipfsHost;
  final String ipfsPort;
  String? ipfsUsername;
  String? ipfsPassword;

  IpfsExporterIsolatedSpwanMessage({
    required this.parentSendPort,
    required this.logSendPort,
    required this.dbSendPort,
    required this.logLevel,
    required this.cronFormat,
    required this.schedule,
    required this.tableDumpPath,
    required this.ipfsScheme,
    required this.ipfsHost,
    required this.ipfsPort,
    this.ipfsUsername,
    this.ipfsPassword,
  });
}

class IpfsExporterIsolated {
  final _logger = Logger('IpfsExporter');

  final SendPort parentSendPort;
  final SendPort logSendPort;
  final SendPort dbSendPort;

  late final ReceivePort receivePort;
  late final Stream<dynamic> receivePortBroadcast;

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

  IpfsExporterIsolated({
    required this.parentSendPort,
    required this.logSendPort,
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
    _logger.level = logLevel;
    _logger.onRecord.listen((logRecord) {
      logSendPort.send(logRecord);
    });
  }

  void init() {
    _initPorts();
    _initDispatch();
    _initSchedule();
  }

  void _initPorts() {
    receivePort = ReceivePort();
    receivePortBroadcast = receivePort.asBroadcastStream();

    parentSendPort.send(receivePort.sendPort);
  }

  void _initDispatch() {
    receivePortBroadcast.listen((message) {
      if (message is IpfsExporterRequestExit) {
        _logger.fine('exiting...');
        _exit(
          replySendPort: message.replySendPort,
        );
      }
    });
  }

  void _initSchedule() {
    _logger.info('scheduled export to IPFS at: $cronFormat');
    _cron.schedule(schedule, _export);
  }

  Future<void> _exit({SendPort? replySendPort}) async {
    _cron.close();

    replySendPort?.send(IpfsExporterResponseExit());

    await Future.delayed(const Duration(milliseconds: 10));

    receivePort.close();
    Isolate.exit();
  }

  Future<void> _export() async {
    await _writeFilesLocally();
    await Future.delayed(Duration(minutes: 15));
    await _writeFilesToIpfs();
  }

  Future<void> _writeFilesLocally() async {
    _logger.info('writing files locally...');

    dbSendPort.send(DbMsgRequestDumpTables(
      replySendPort: receivePort.sendPort,
      dumpPath: tableDumpPath,
      dumpExt: fileExtData,
    ));
    var response = await receivePortBroadcast
        .where((event) => event is DbMsgResponseDumpTables)
        .first;

    if (response.exception != null) {
      _logger.severe(response.exception!);
    } else {
      _logger.info('writing files locally... done.');
    }
  }

  Future<void> _writeFilesToIpfs() async {
    _logger.info('uploading files to ipfs...');

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
      _logger.info('uploading $dataName to IPFS...');

      var hash = await _ipfsAdd(client, ipfsUri, dataName);
      if (hash == null) {
        continue;
      }
      _logger.info('uploading $dataName to IPFS... done. Hash: $hash.');

      _logger.info('writing hash to $dataName.$fileExtHash...');
      await _writeHash(dataName, hash);
      _logger.info('wroting hash to $dataName.$fileExtHash... done.');
    }

    client.close();

    _logger.info('uploading files to ipfs... done.');
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
      _logger.warning(ex);
      return null;
    }

    if (responseBodyIpfsAddDecoded is! Map) {
      _logger.warning('ipfs add error: '
          'reponse body is not a Map '
          'body=${responseBodyIpfsAdd}.');
      return null;
    }

    if (!responseBodyIpfsAddDecoded.containsKey('Hash')) {
      _logger.warning('ipfs add error: '
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
    var requestIpfsAdd = http.MultipartRequest(
      'POST',
      ipfsUri,
    );

    if (ipfsUsername != null && ipfsPassword != null) {
      var basicAuth = base64.encode(utf8.encode('$ipfsUsername:$ipfsPassword'));
      requestIpfsAdd.headers['Authorization'] = 'Basic $basicAuth';
    }

    var multipartFile = await http.MultipartFile.fromPath(
      'data',
      p.join(tableDumpPath, '$dataName.$fileExtData'),
    );
    requestIpfsAdd.files.add(multipartFile);

    var ipfsRequestRetryCountIndex = 1;

    while (ipfsRequestRetryCountIndex <= ipfsRequestRetryCountMax) {
      _logger.info('uploading $dataName to IPFS...'
          ' Retry $ipfsRequestRetryCountIndex/$ipfsRequestRetryCountMax.');

      var responseIpfsAdd = await httpClient.send(requestIpfsAdd);
      var responseBodyIpfsAdd = await responseIpfsAdd.stream.bytesToString();

      if (responseIpfsAdd.statusCode == 200) {
        return responseBodyIpfsAdd;
      }

      _logger.warning('ipfs add error: '
          'code=${responseIpfsAdd.statusCode} '
          'body=${responseBodyIpfsAdd}.');

      _logger.info('ipfs add: '
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

abstract class IpfsExporterMsg {}

abstract class IpfsExporterMsgRequest extends IpfsExporterMsg {
  final SendPort? replySendPort;
  IpfsExporterMsgRequest({
    this.replySendPort,
  });
}

abstract class IpfsExporterMsgResponse extends IpfsExporterMsg {}

class IpfsExporterRequestExit extends IpfsExporterMsgRequest {
  IpfsExporterRequestExit({
    super.replySendPort,
  });
}

class IpfsExporterResponseExit extends IpfsExporterMsgResponse {}

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

    for (var fileName in ['chat', 'message', 'user']) {
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
        p.join(tableDumpPath, '$fileName.$fileExtData'),
      );
      requestIpfsAdd.files.add(multipartFile);

      var responseIpfsAdd = await client.send(requestIpfsAdd);
      var responseBodyIpfsAdd = await responseIpfsAdd.stream.bytesToString();

      if (responseIpfsAdd.statusCode != 200) {
        _logger.severe('ipfs add error: '
            'code=${responseIpfsAdd.statusCode} '
            'body=${responseBodyIpfsAdd}.');
        continue;
      }

      var responseBodyIpfsAddDecoded;
      try {
        responseBodyIpfsAddDecoded = jsonDecode(responseBodyIpfsAdd);
      } on FormatException catch (ex) {
        _logger.severe(ex);
        continue;
      }

      if (responseBodyIpfsAddDecoded is! Map) {
        _logger.severe('ipfs add error: '
            'reponse body is not a Map '
            'body=${responseBodyIpfsAdd}.');
        continue;
      }

      if (!responseBodyIpfsAddDecoded.containsKey('Hash')) {
        _logger.severe('ipfs add error: '
            'reponse body without the Hash key '
            'body=${responseBodyIpfsAdd}.');
        continue;
      }

      var hash = responseBodyIpfsAddDecoded['Hash'];
      _logger.info('uploaded $fileName with hash $hash.');

      var fileHash = new File(p.join(tableDumpPath, '$fileName.$fileExtHash'));
      fileHash.createSync();

      final sink = fileHash.openWrite(mode: FileMode.write);
      sink.write(hash);
      sink.write('\n');

      await sink.flush();
      await sink.close();

      _logger.info('wrote hash to $fileName.$fileExtHash.');
    }

    client.close();

    _logger.info('uploading files to ipfs... done.');
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

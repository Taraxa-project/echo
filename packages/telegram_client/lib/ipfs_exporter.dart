import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:cron/cron.dart';
import 'package:path/path.dart' as p;

import 'log.dart';
import 'db.dart';

class IpfsExporter {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort isolateSendPort;

  final _logger = Logger('IpfsExporter');

  late final Log _log;
  late final Db _db;

  String cronFormat;
  Schedule schedule;

  IpfsExporter({
    required Level logLevel,
    required this.cronFormat,
    required this.schedule,
  }) {
    _logger.level = logLevel;
  }

  Future<void> spawn({
    required Log log,
    required Db db,
    required String tableDumpPath,
  }) async {
    _log = log;
    _db = db;

    _logger.onRecord.listen((event) {
      _log.isolateSendPort.send(event);
    });

    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();

    await Isolate.spawn(
      IpfsExporter._entryPoint,
      IpfsExporterIsolatedSpwanMessage(
        parentSendPort: _isolateReceivePort.sendPort,
        logSendPort: _log.isolateSendPort,
        dbSendPort: _db.isolateSendPort,
        logLevel: _logger.level,
        cronFormat: cronFormat,
        schedule: schedule,
        tableDumpPath: tableDumpPath,
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
    );
    lgIsolated.init();

    lgIsolated._logger.fine('spawned.');
  }

  Future<void> exit() async {
    isolateSendPort.send(IpfsExporterRequestExit(
      replySendPort: _isolateReceivePort.sendPort,
    ));
    await _isolateReceivePortBroadcast
        .where((event) => event is IpfsExporterRequestExit)
        .first;
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

  IpfsExporterIsolatedSpwanMessage({
    required this.parentSendPort,
    required this.logSendPort,
    required this.dbSendPort,
    required this.logLevel,
    required this.cronFormat,
    required this.schedule,
    required this.tableDumpPath,
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

  final _cron = Cron();

  static const String ipfs_uri = '127.0.0.1:5001';
  static const String ipfs_dir = '/echo_telegram';
  static const String file_ext_data = 'csv';
  static const String file_ext_hash = 'hash';

  IpfsExporterIsolated({
    required this.parentSendPort,
    required this.logSendPort,
    required this.dbSendPort,
    required Level logLevel,
    required this.cronFormat,
    required this.schedule,
    required this.tableDumpPath,
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
    await Future.delayed(Duration(seconds: 10));
    await _writeFilesToIpfs();
  }

  Future<void> _writeFilesLocally() async {
    _logger.info('writing files locally...');

    dbSendPort.send(DbMsgRequestDumpTables(
      replySendPort: receivePort.sendPort,
      dumpPath: tableDumpPath,
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

    for (var fileName in ['chat', 'message', 'user']) {
      var uriWrite = Uri.http(
        ipfs_uri,
        '/api/v0/files/write',
        {
          'arg': '$ipfs_dir/$fileName.$file_ext_data',
          'parents': 'true',
          'create': 'true',
        },
      );
      var requestWrite = http.MultipartRequest('POST', uriWrite);
      var multipartFile = await http.MultipartFile.fromPath(
        'data',
        p.join(tableDumpPath, '$fileName.$file_ext_data'),
      );
      requestWrite.files.add(multipartFile);
      await client.send(requestWrite);

      var uriStat = Uri.http(
        ipfs_uri,
        '/api/v0/files/stat',
        {
          'arg': '$ipfs_dir/$fileName.$file_ext_data',
        },
      );
      var requestStat = http.Request('POST', uriStat);

      var responseStat = await client.send(requestStat);
      var responseBodyStat = await responseStat.stream.bytesToString();
      var responseBodyStatDecoded = jsonDecode(responseBodyStat);

      var fileHash =
          new File(p.join(tableDumpPath, '$fileName.$file_ext_hash'));
      fileHash.createSync();

      final sink = fileHash.openWrite(mode: FileMode.write);
      sink.write(responseBodyStatDecoded['Hash']);
      sink.write('\n');

      await sink.flush();
      await sink.close();
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

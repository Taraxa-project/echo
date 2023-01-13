import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';

import 'lg.dart';

class Db {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort isolateSendPort;

  late final Lg _lg;

  final _logger = Logger('Db');

  Future<void> spawn({
    required Lg lg,
  }) async {
    _lg = lg;

    _logger.onRecord.listen((event) {
      _lg.isolateSendPort.send(event);
    });

    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
    _isolateReceivePortBroadcast
        .where((event) => event is LogRecord)
        .listen((logRecord) {
      _lg.isolateSendPort.send(logRecord);
    });

    _logger.info('spawning DbIsolated...');
    await Isolate.spawn(
      Db._entryPoint,
      [
        _isolateReceivePort.sendPort,
      ],
      debugName: runtimeType.toString(),
    );

    isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(dynamic initialSpawnMessage) {
    SendPort parentSendPort = initialSpawnMessage[0];

    final dbIsolated = DbIsolated(parentSendPort: parentSendPort);

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is DbExit) {
        dbIsolated._logger.info('exiting...');
        receivePort.close();
        Isolate.exit();
      }
    });
    dbIsolated._logger.info('spawned.');
  }

  Future<void> exit() async {
    isolateSendPort.send(DbExit());
    await Future.delayed(const Duration(milliseconds: 10));
    _isolateReceivePort.close();
  }
}

abstract class DbMsg {}

class DbExit extends DbMsg {}

class DbIsolated {
  final _logger = Logger('DbIsolated');
  final SendPort parentSendPort;

  DbIsolated({required this.parentSendPort}) {
    _logger.onRecord.listen((logRecord) {
      parentSendPort.send(logRecord);
    });
  }
}

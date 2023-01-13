import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';

import 'lg.dart';
import 'db.dart';

class Tg {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort _isolateSendPort;

  late final Lg _lg;
  late final Db _db;

  final _logger = Logger('Tg');

  Future<void> spawn({
    required Lg lg,
    required Db db,
  }) async {
    _lg = lg;
    _db = db;

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

    _logger.info('spawning TgIsolated...');
    await Isolate.spawn(
      Tg._entryPoint,
      [
        _isolateReceivePort.sendPort,
      ],
      debugName: runtimeType.toString(),
    );

    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(dynamic initialSpawnMessage) {
    SendPort parentSendPort = initialSpawnMessage[0];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    final tgIsolated = TgIsolated(parentSendPort: parentSendPort);

    receivePort.listen((message) {
      if (message is TgExit) {
        tgIsolated._logger.info('exiting...');
        receivePort.close();
        Isolate.exit();
      } else if (message is TgLogin) {
        parentSendPort.send(tgIsolated.login());
      } else if (message is TgReadChatsHistory) {
        tgIsolated.readChatsHistory();
      }
    });

    tgIsolated._logger.info('spawned.');
  }

  Future<void> exit() async {
    _isolateSendPort.send(TgExit());
    await Future.delayed(const Duration(milliseconds: 10));
    _isolateReceivePort.close();
  }

  Future<dynamic> login() async {
    _isolateSendPort.send(TgLogin());

    var response;
    var sub = _isolateReceivePortBroadcast.listen((event) {
      if (event is TgIsolatedLogin) {
        response = event;
      }
    });

    while (true) {
      if (response != null) {
        sub.cancel();
        return response;
      }
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  Future<void> readChatsHistory() async {
    _isolateSendPort.send(TgReadChatsHistory());
  }
}

abstract class TgMsg {}

class TgLogin extends TgMsg {}

class TgReadChatsHistory extends TgMsg {}

class TgExit extends TgMsg {}

class TgIsolated {
  final _logger = Logger('TgIsolated');
  final SendPort parentSendPort;

  TgIsolated({required this.parentSendPort}) {
    _logger.onRecord.listen((logRecord) {
      parentSendPort.send(logRecord);
    });
  }

  TgIsolatedLogin login() {
    _logger.info('loggin in...');
    return TgIsolatedLogin();
  }

  void readChatsHistory() {
    _logger.info('reading chats history...');
  }
}

class TgIsolatedLogin {}

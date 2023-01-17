import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';

class Log {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort isolateSendPort;

  final _logger = Logger('Log');

  Log({
    required Level logLevel,
  }) {
    _logger.level = logLevel;
  }

  Future<void> spawn() async {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();

    await Isolate.spawn(
      Log._entryPoint,
      LgIsolatedSpwanMessage(
        parentSendPort: _isolateReceivePort.sendPort,
      ),
      debugName: runtimeType.toString(),
    );

    isolateSendPort = await _isolateReceivePortBroadcast.first;

    _logger.onRecord.listen((event) {
      isolateSendPort.send(event);
    });
  }

  static void _entryPoint(LgIsolatedSpwanMessage initialSpawnMessage) {
    final lgIsolated = LogIsolated(
      parentSendPort: initialSpawnMessage.parentSendPort,
    );
    lgIsolated.init();

    lgIsolated._logger.fine('spawned.');
  }

  Future<void> exit() async {
    isolateSendPort.send(LgMsgRequestExit());
    await _isolateReceivePortBroadcast
        .where((event) => event is LgMsgResponseExit)
        .first;
    _isolateReceivePort.close();
  }
}

class LgIsolatedSpwanMessage {
  final SendPort parentSendPort;

  LgIsolatedSpwanMessage({
    required this.parentSendPort,
  });
}

class LogIsolated {
  final _logger = Logger('LogIsolated');

  final SendPort parentSendPort;

  late final ReceivePort receivePort;
  late final Stream<dynamic> receivePortBroadcast;

  LogIsolated({
    required this.parentSendPort,
  }) {
    _logger.onRecord.listen((event) {
      if (event.object != null && event.object is LogRecord) {
        log(event.object as LogRecord);
      } else {
        log(event);
      }
    });
  }

  void init() {
    _initPorts();
    _initDispatch();
  }

  void _initPorts() {
    receivePort = ReceivePort();
    receivePortBroadcast = receivePort.asBroadcastStream();

    parentSendPort.send(receivePort.sendPort);
  }

  void _initDispatch() {
    receivePort.listen((message) {
      if (message is LgMsgRequestExit) {
        _logger.fine('exiting...');
        _exit();
      } else if (message is LogRecord) {
        logExternal(message);
      }
    });
  }

  Future<void> _exit() async {
    parentSendPort.send(LgMsgResponseExit());
    await Future.delayed(const Duration(milliseconds: 10));

    receivePort.close();
    Isolate.exit();
  }

  void logExternal(LogRecord logRecord) {
    _logger.log(logRecord.level, logRecord);
  }

  void log(LogRecord logRecord) {
    print(logRecord);
  }
}

abstract class LgMsg {}

abstract class DbMsgRequest extends LgMsg {}

abstract class DbMsgResponse extends LgMsg {}

class LgMsgRequestExit extends DbMsgRequest {}

class LgMsgResponseExit extends DbMsgResponse {}

import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:td_json_client/td_json_client.dart';

class Lg {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort isolateSendPort;

  final _logger = Logger('Lg');

  Future<void> spawn() async {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();

    await Isolate.spawn(
      Lg._entryPoint,
      [
        _isolateReceivePort.sendPort,
      ],
      debugName: runtimeType.toString(),
    );

    isolateSendPort = await _isolateReceivePortBroadcast.first;

    _logger.onRecord.listen((event) {
      isolateSendPort.send(event);
    });
  }

  static void _entryPoint(dynamic initialSpawnMessage) {
    SendPort parentSendPort = initialSpawnMessage[0];

    final lgIsolated = LgIsolated();

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is LgExit) {
        lgIsolated._logger.info('exiting...');
        receivePort.close();
        Isolate.exit();
      } else if (message is LogRecord) {
        lgIsolated.logExternal(message);
      }
    });

    lgIsolated._logger.info('Spawned.');
  }

  void exit() {
    isolateSendPort.send(LgExit());
    _isolateReceivePort.close();
  }
}

abstract class LgMsg {}

class LgExit extends LgMsg {}

class LgIsolated {
  final _logger = Logger('LgIsolated');
  LgIsolated() {
    _logger.onRecord.listen((event) {
      if (event.object != null && event.object is LogRecord) {
        var logRecord = event.object as LogRecord;
        log(logRecord);
      } else {
        log(event);
      }
    });
  }

  void logExternal(LogRecord logRecord) {
    _logger.log(logRecord.level, logRecord);
  }

  void log(LogRecord logRecord) {
    print(logRecord);
  }
}

import 'dart:async';
import 'dart:isolate';

import 'lg.dart';

class Db {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort _isolateSendPort;

  late final Lg _lg;

  Future<void> spawn({
    required Lg lg,
  }) async {
    _lg = lg;

    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();

    await Isolate.spawn(
      Db._entryPoint,
      [
        _isolateReceivePort.sendPort,
      ],
      debugName: runtimeType.toString(),
    );

    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(dynamic initialSpawnMessage) {
    SendPort parentSendPort = initialSpawnMessage[0];

    final dbIsolated = DbIsolated();

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is DbExit) {
        print('${Isolate.current.debugName}: existing...');
        receivePort.close();
        Isolate.exit();
      }
    });

    print('${Isolate.current.debugName}: spawned...');
  }

  void exit() {
    _isolateSendPort.send(DbExit());
    _isolateReceivePort.close();
  }
}

abstract class DbMsg {}

class DbExit extends DbMsg {}

class DbIsolated {}

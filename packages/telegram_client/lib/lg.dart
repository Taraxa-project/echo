import 'dart:async';
import 'dart:isolate';

class Lg {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort _isolateSendPort;

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

    _isolateSendPort = await _isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(dynamic initialSpawnMessage) {
    SendPort parentSendPort = initialSpawnMessage[0];

    final lgIsolated = LgIsolated();

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is LgExit) {
        print('${Isolate.current.debugName}: existing...');
        receivePort.close();
        Isolate.exit();
      }
    });

    print('${Isolate.current.debugName}: spawned...');
  }

  void exit() {
    _isolateSendPort.send(LgExit());
    _isolateReceivePort.close();
  }
}

abstract class LgMsg {}

class LgExit extends LgMsg {}

class LgIsolated {}

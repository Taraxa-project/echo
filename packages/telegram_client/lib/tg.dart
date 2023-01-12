import 'dart:async';
import 'dart:isolate';

class Tg {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  late final SendPort _isolateSendPort;

  Future<void> spawn() async {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();

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

    final tgIsolated = TgIsolated();

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is TgExit) {
        receivePort.close();
        Isolate.exit();
      } else if (message is TgLogin) {
        parentSendPort.send(tgIsolated.login());
      } else if (message is TgReadChatsHistory) {
        tgIsolated.readChatsHistory();
      }
    });
  }

  void exit() async {
    _isolateSendPort.send(TgExit());
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
  TgIsolatedLogin login() {
    print('${Isolate.current.debugName}:${runtimeType.toString()}:login');
    return TgIsolatedLogin();
  }

  void readChatsHistory() {
    print(
        '${Isolate.current.debugName}:${runtimeType.toString()}:readChatsHistory');
  }
}

class TgIsolatedLogin {}

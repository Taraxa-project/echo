import 'dart:isolate';

import 'package:uuid/uuid.dart';

mixin WithPorts {
  void handlePortMessage(dynamic portMessage);

  ReceivePort? _receivePort;
  SendPort? get sendPort => _receivePort?.sendPort;

  ReceivePort? _isolateReceivePort;
  SendPort? _isolateSendPort;

  bool _isIsolated = false;
  bool get isIsolated => _isIsolated;

  Future<void> initPorts({
    bool isolated: false,
  }) async {
    closePorts();

    _isIsolated = isolated;

    if (isolated) {
      var isolateReceivePort = ReceivePort();
      await Isolate.spawn(
        WithPorts._entryPoint,
        [this, isolateReceivePort.sendPort],
        debugName: runtimeType.toString(),
      );
      _isolateReceivePort = isolateReceivePort;
      _isolateSendPort = await _isolateReceivePort?.first;
    }

    _receivePort = ReceivePort();
    if (isolated) {
      _receivePort?.listen((message) {
        _isolateSendPort?.send(message);
      });
    } else {
      _receivePort?.listen((message) {
        if (message is Subscribe) {
          subscribe(message.sendPort);
        } else if (message is Unsubscribe) {
          unsubscribe();
        } else {
          handlePortMessage(message);
        }
      });
    }
  }

  void closePorts() {
    _isolateSendPort?.send(IsolateExit());

    _receivePort?.close();
    _receivePort = null;

    _isolateReceivePort?.close();
    _isolateReceivePort = null;
  }

  static void _entryPoint(List<dynamic> initialSpawnMessage) {
    WithPorts self = initialSpawnMessage[0];
    SendPort parentSendPort = initialSpawnMessage[1];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      if (message is IsolateExit) {
        Isolate.exit();
      } else if (message is Subscribe) {
        self.subscribe(message.sendPort);
      } else if (message is Unsubscribe) {
        self.unsubscribe();
      } else {
        self.handlePortMessage(message);
      }
    });
  }

  void sendMessage(dynamic portMessage) {
    sendPort?.send(portMessage);
  }

  String? _subscribeUniqueKey;

  SendPort? subscribedSendPort;
  ReceivePort? _subscribedReceivePort;
  Stream<dynamic>? subscribedEvents;

  void subscribe(SendPort? sendPort) {
    subscribedSendPort = sendPort;

    _subscribeUniqueKey = Uuid().v1();

    _subscribedReceivePort = ReceivePort();
    subscribedSendPort?.send(SubscribeEvents(
      uniqueKey: _subscribeUniqueKey,
      sendPort: _subscribedReceivePort!.sendPort,
    ));

    subscribedEvents = _subscribedReceivePort!.asBroadcastStream();
  }

  void unsubscribe() {
    subscribedSendPort?.send(UnsubscribeEvents(
      uniqueKey: _subscribeUniqueKey,
      sendPort: _subscribedReceivePort!.sendPort,
    ));
    _subscribedReceivePort?.close();
  }
}

class IsolateExit {}

class Subscribe {
  SendPort? sendPort;
  Subscribe(this.sendPort);
}

class Unsubscribe {}

class SubscribeEvents {
  final String? uniqueKey;
  final SendPort? sendPort;
  SubscribeEvents({
    this.uniqueKey,
    this.sendPort,
  });
}

class UnsubscribeEvents {
  final String? uniqueKey;
  final SendPort? sendPort;
  UnsubscribeEvents({
    this.uniqueKey,
    this.sendPort,
  });
}

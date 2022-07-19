import 'dart:async';
import 'dart:isolate';

abstract class PortMessage {}

abstract class PortMessageHandler {
  void handle(PortMessage portMessage);
  Stream<dynamic> get events;
}

class PortMessenger {
  late final ReceivePort _receivePort = ReceivePort();
  SendPort get sendPort => _receivePort.sendPort;

  late final StreamController _streamController;
  Stream<dynamic> get events => _streamController.stream;

  final PortMessageHandler portMessageHandler;
  late final StreamSubscription _portMessageHandlerSubscription;

  PortMessenger({
    required this.portMessageHandler,
  }) {
    _receivePort.listen((message) {
      portMessageHandler.handle(message);
    });

    _streamController = StreamController.broadcast();
    _portMessageHandlerSubscription = portMessageHandler.events.listen((event) {
      _streamController.add(event);
    });
  }

  void exit() {
    _portMessageHandlerSubscription.cancel();
    _receivePort.close();
  }

  static Future<PortMessengerIsolated> isolate({
    required PortMessageHandler portMessageHandler,
  }) async {
    var portMessengerIsolated =
        PortMessengerIsolated(portMessageHandler: portMessageHandler);
    await portMessengerIsolated.spawn();
    return portMessengerIsolated;
  }
}

class PortMessengerIsolated {
  late final ReceivePort _receivePort = ReceivePort();
  SendPort get sendPort => _receivePort.sendPort;

  final PortMessageHandler portMessageHandler;

  @override
  PortMessengerIsolated({
    required this.portMessageHandler,
  }) {
    _receivePort.listen((message) {
      _isolateSendPort.send(message);
    });

    _streamController = StreamController.broadcast();
  }

  final ReceivePort _isolateReceivePort = ReceivePort();
  late final Stream<dynamic> _isolateReceivePortBroacast;
  late final SendPort _isolateSendPort;
  late final StreamSubscription _isolateSubscription;

  late final StreamController _streamController;
  Stream<dynamic> get events => _streamController.stream;

  Future<void> spawn() async {
    await Isolate.spawn(
      PortMessengerIsolated._entryPoint,
      [portMessageHandler, _isolateReceivePort.sendPort],
      debugName: portMessageHandler.runtimeType.toString(),
    );
    _isolateReceivePortBroacast = _isolateReceivePort.asBroadcastStream();
    _isolateSendPort = await _isolateReceivePortBroacast.first;

    _isolateSubscription = _isolateReceivePortBroacast.listen((event) {
      _streamController.add(event);
    });
  }

  static void _entryPoint(List<dynamic> initialSpawnMessage) {
    var portMessageHandler = initialSpawnMessage[0];
    var parentSendPort = initialSpawnMessage[1];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      portMessageHandler.handle(message);
    });
    portMessageHandler.events.listen((message) {
      parentSendPort.send(message);
    });
  }

  void exit() {
    _isolateSubscription.cancel();
    _isolateReceivePort.close();
    _receivePort.close();
  }
}

import 'dart:isolate';

mixin WithPorts {
  ReceivePort? _receivePort;
  SendPort? get sendPort => _receivePort?.sendPort;

  void handlePortMessage(dynamic portMessage);

  initPorts() {
    _closePorts();

    _receivePort = ReceivePort();
    _receivePort?.listen((message) {
      handlePortMessage(message);
    });
  }

  ReceivePort? _isolateReceivePort;
  SendPort? _isolateSendPort;

  initPortsIsolate() async {
    _closePorts();

    var isolateReceivePort = ReceivePort();
    await Isolate.spawn(
      WithPorts._entryPoint,
      [this, isolateReceivePort.sendPort],
      debugName: runtimeType.toString(),
    );
    _isolateReceivePort = isolateReceivePort;
    _isolateSendPort = await _isolateReceivePort?.first;

    _receivePort = ReceivePort();
    _receivePort?.listen((message) {
      _isolateSendPort?.send(message);
    });
  }

  void exit() {
    _closePorts();
  }

  void _closePorts() {
    _isolateReceivePort?.close();
    _isolateReceivePort = null;

    _receivePort?.close();
    _receivePort = null;
  }

  static void _entryPoint(List<dynamic> initialSpawnMessage) {
    WithPorts self = initialSpawnMessage[0];
    SendPort parentSendPort = initialSpawnMessage[1];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      self.handlePortMessage(message);
    });
  }
}

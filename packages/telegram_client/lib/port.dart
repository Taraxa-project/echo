import 'dart:isolate';

mixin WithPorts {
  ReceivePort? _receivePort;
  SendPort? get sendPort => _receivePort?.sendPort;

  void handlePortMessage(dynamic portMessage);

  initPorts() {
    closePorts();

    _receivePort = ReceivePort();
    _receivePort?.listen((message) {
      handlePortMessage(message);
    });
  }

  ReceivePort? _isolateReceivePort;
  SendPort? _isolateSendPort;

  initPortsIsolate() async {
    closePorts();

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
      } else {
        self.handlePortMessage(message);
      }
    });
  }
}

class IsolateExit {}

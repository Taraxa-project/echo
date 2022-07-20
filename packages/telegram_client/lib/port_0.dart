import 'dart:isolate';

abstract class PortMessage {}

abstract class WithPorts {
  final ReceivePort _receivePort = ReceivePort();
  SendPort get sendPort => _receivePort.sendPort;

  void handlePortMessage(PortMessage portMessage);

  WithPorts() {
    _receivePort.listen((message) {
      handlePortMessage(message);
    });
  }

  void exit() {
    _receivePort.close();
  }
}

abstract class WithPortIsolated extends WithPorts {
  late final SendPort? _isolateSendPort;

  WithPortIsolated() {
    _receivePort.listen((message) {
      _isolateSendPort?.send(message);
    });
  }

  final ReceivePort _isolateReceivePort = ReceivePort();

  Future<void> spawn() async {
    await Isolate.spawn(
      WithPortIsolated._entryPoint,
      [this, _isolateReceivePort.sendPort],
      debugName: runtimeType.toString(),
    );
    _isolateSendPort = await _isolateReceivePort.first;
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

  @override
  void exit() {
    _receivePort.close();
    super.exit();
  }
}

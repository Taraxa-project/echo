import 'dart:isolate';

// Interface with the call method
abstract class Callable {
  void call(dynamic message);
}

// The example class
class Foo extends Callable {
  void printMessage(String message) {
    print('${Isolate.current.debugName} A:printMessage $message');
  }

  // Dispatch message to the appropiate method
  void call(dynamic message) {
    if (message is FooPrintMessage) {
      printMessage(message.text);
    }
  }
}

// Wrapper over callable with ports
// Using ports allows methods to be called from other isolates also
// Use the property [sendPort] to send messages
class CallableWithPorts {
  // Messages sent to the [sendPort] are received in [_receivedPort]
  final ReceivePort _receivePort = ReceivePort();

  // Use this to send messages to the wrapped [Callable] class
  SendPort get sendPort => _receivePort.sendPort;

  // Wrap the callable
  final Callable callable;
  CallableWithPorts({
    required this.callable,
  }) {
    _receivePort.listen((message) {
      callable.call(message);
    });
  }

  // Call this when you're done
  void exit() {
    _receivePort.close();
  }
}

// Wrapper over callable with ports in isolate
// Using ports allows methods to be called from both main or other isolates
// The messages are forwarded to the isolate
class CallableWithPortsIsolated {
  // Messages sent to the [sendPort] are received in [_receivedPort]
  final ReceivePort _receivePort = ReceivePort();

  // Use this to send messages to the wrapped [Callable] class
  SendPort get sendPort => _receivePort.sendPort;

  final Callable callable;
  CallableWithPortsIsolated({
    required this.callable,
  }) {
    // When we receive messages we send them to the isolate
    _receivePort.listen((message) {
      _isolateSendPort.send(message);
    });
  }

  // Port to comunicate to the underlying isolate
  final ReceivePort _isolateReceivePort = ReceivePort();
  late final SendPort _isolateSendPort;

  // Spawns the isolate and receive the port used to send messages to the isolate
  Future<void> spawn() async {
    await Isolate.spawn(
        _entryPoint,
        SpawnMessage(
          wrapped: callable,
          sendPort: _isolateReceivePort.sendPort,
        ),
        debugName: runtimeType.toString());
    _isolateSendPort = await _isolateReceivePort.first;
  }

  static void _entryPoint(SpawnMessage spawnMessage) {
    var callable = spawnMessage.wrapped;
    var sendPort = spawnMessage.sendPort;

    var receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) {
      callable.send(message);
    });
  }

  void exit() {
    _isolateReceivePort.close();
    _receivePort.close();
  }
}

void main() async {
  var foo = Foo();

  // Call main Foo.printMessage from main isolate
  var callableWithPorts = CallableWithPorts(
    callable: foo,
  );
  callableWithPorts.sendPort.send(FooPrintMessage(
    text: 'A message from main.',
  ));

  // Call isolated Foo.printMessage from main isolate
  var callableWithPortsIsolated = CallableWithPortsIsolated(
    callable: foo,
  );
  await callableWithPortsIsolated.spawn();
  callableWithPortsIsolated.sendPort.send(FooPrintMessage(
    text: 'Another message from main.',
  ));

  // Call Foo.printMessage (main and isolated) from another isolate
  await Isolate.spawn(_callFoo, foo, debugName: '_callFoo');

  // wait for async event processing
  await Future.delayed(Duration(seconds: 5));
  // close ports/isolates
  callableWithPorts.exit();
  callableWithPortsIsolated.exit();
}

class FooPrintMessage {
  String text;
  FooPrintMessage({
    required this.text,
  });
}

class SpawnMessage {
  dynamic wrapped;
  SendPort sendPort;
  SpawnMessage({
    required this.wrapped,
    required this.sendPort,
  });
}

void _callFoo(Foo foo) async {
  // Call main Foo.printMessage from main isolate
  var callableWithPorts = CallableWithPorts(
    callable: foo,
  );
  callableWithPorts.sendPort.send(FooPrintMessage(
    text: 'A message from isolate ${Isolate.current.debugName}.',
  ));

  // Call isolated Foo.printMessage from main isolate
  var callableWithPortsIsolated = CallableWithPortsIsolated(
    callable: foo,
  );
  await callableWithPortsIsolated.spawn();
  callableWithPortsIsolated.sendPort.send(FooPrintMessage(
    text: 'Another message from isolate ${Isolate.current.debugName}.',
  ));
}

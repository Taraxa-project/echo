import 'dart:isolate';

import 'package:uuid/uuid.dart';

class Isolater {
  static Future<SendPort> spawn(
    void Function(dynamic) entryPoint, [
    dynamic init,
    String? debugName,
  ]) async {
    var receivePort = ReceivePort();

    final Isolate isolate;
    try {
      isolate = await Isolate.spawn(
        entryPoint,
        IsolateSpawnMessage(receivePort.sendPort, init),
        onError: receivePort.sendPort,
        debugName: debugName,
      );
    } on Object {
      receivePort.close();
      rethrow;
    }

    final response = await receivePort.first;
    receivePort.close();

    await Future.delayed(const Duration(seconds: 3));
    if (response == null) {
      throw RemoteError('Isolate finished without result', '');
    } else if (response is List<dynamic>) {
      isolate.kill(priority: Isolate.immediate);
      throw RemoteError(response[0], response[1]);
    } else if (response is! SendPort) {
      isolate.kill(priority: Isolate.immediate);
      throw RemoteError(
          'Isolate response is not SendPort: ${response.runtimeType}', '');
    }

    return response;
  }
}

class IsolatedProxy {
  final SendPort sendPort;
  IsolatedProxy(this.sendPort);

  dynamic call(message) async {
    final receivePort = ReceivePort();
    final isolateCall = IsolateCall(receivePort.sendPort, message);
    final first = receivePort.firstWhere((element) {
      return element.uuid == isolateCall.uuid;
    });
    sendPort.send(isolateCall);
    final result = await first;
    receivePort.close();

    if (result is IsolateCallResult) {
      return result.payload;
    } else if (result is IsolateCallException) {
      throw result.payload;
    } else {
      throw Exception('Invalid response type: ${result.runtimeType}');
    }
  }

  send(isolateMessage) {
    sendPort.send(isolateMessage);
  }

  void exit() {
    send(IsolateExit());
  }
}

abstract class IsolatedDispatch {
  final ReceivePort receivePort = ReceivePort();

  IsolatedDispatch() {
    receivePort.listen((event) async {
      if (event is IsolateCall) {
        try {
          final result = await dispatch(event.isolateMessage);
          final isolateCallResult = IsolateCallResult(event, result);
          event.replySendPort.send(isolateCallResult);
        } on Object catch (ex) {
          event.replySendPort.send(IsolateCallException(event, ex));
        }
      } else {
        await dispatch(event);
      }
    });
  }

  dynamic dispatch(message) {
    if (message is! IsolateExit)
      throw Exception('Don\'t know to dispatch ${message.runtimeType}');
    exit();
  }

  void exit() {
    Isolate.exit();
  }
}

class IsolateSpawnMessage {
  final SendPort sendPort;
  final dynamic init;

  IsolateSpawnMessage(this.sendPort, [this.init]);
}

class IsolateCall {
  final String uuid = Uuid().v4();
  final SendPort replySendPort;
  final isolateMessage;

  IsolateCall(this.replySendPort, [this.isolateMessage]) {}
}

class IsolateCallResult {
  final String uuid;
  final payload;

  IsolateCallResult(IsolateCall isolateCall, this.payload)
      : uuid = isolateCall.uuid {}
}

class IsolateCallException {
  final String uuid;
  final payload;

  IsolateCallException(IsolateCall isolateCall, this.payload)
      : uuid = isolateCall.uuid {}
}

class IsolateSpawnException {
  final String exception;
  final String? exceptionTrace;

  IsolateSpawnException(this.exception, [this.exceptionTrace]) {}
}

class IsolateExit {}

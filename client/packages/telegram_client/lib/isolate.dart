import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:td_json_client/td_api.dart';

class Isolater {
  final ReceivePort receivePort = ReceivePort();
  final ReceivePort receivePortError = ReceivePort();
  late final Stream<dynamic> receivePortBroadcast;

  SendPort? sendPort;

  Isolater() {
    receivePortBroadcast = receivePort.asBroadcastStream();
  }

  Future<void> spawn_(Isolated isolated, {String? debugName}) async {
    var ex;
    receivePortError.listen((message) {
      ex = IsolateException(message[0], message[1]);
    });

    await Isolate.spawn(
      _entryPoint,
      IsolateSpawnMessage(isolated, receivePort.sendPort),
      onError: receivePortError.sendPort,
      debugName: debugName ?? runtimeType.toString(),
    );

    await Future.delayed(const Duration(seconds: 5));
    if (ex != null) {
      throw ex;
    }

    sendPort = await receivePortBroadcast.first;
  }

  static void _entryPoint(IsolateSpawnMessage isolateSpawnMessage) {
    hierarchicalLoggingEnabled = true;
    isolateSpawnMessage.isolated.init(isolateSpawnMessage.parentSendPort);
  }

  Future<void> exit() async {
    if (sendPort != null) {
      sendPort!.send(IsolateMsgRequestExit(
        replySendPort: receivePort.sendPort,
      ));
      await receivePortBroadcast
          .firstWhere((element) => element is IsolateMsgResponseExit);
    }
    receivePort.close();
    receivePortError.close();
  }
}

class IsolateSpawnMessage {
  final Isolated isolated;
  final SendPort parentSendPort;
  IsolateSpawnMessage(this.isolated, this.parentSendPort);
}

abstract class Isolated {
  late final Logger logger;

  late final SendPort parentSendPort;

  late final ReceivePort receivePort;
  late final Stream<dynamic> receivePortBroadcast;

  Isolated({
    Level? logLevel,
  }) {
    logger = Logger(runtimeType.toString());
    logger.level = logLevel;
  }

  void init(SendPort parentSendPort) {
    initPorts(parentSendPort);
    initDispatch();
  }

  void initPorts(SendPort parentSendPort) {
    this.parentSendPort = parentSendPort;

    receivePort = ReceivePort();
    receivePortBroadcast = receivePort.asBroadcastStream();

    parentSendPort.send(receivePort.sendPort);
  }

  void initDispatch() {}

  Future<void> exit(SendPort? replySendPort) async {
    replySendPort?.send(IsolateMsgResponseExit());

    await Future.delayed(const Duration(milliseconds: 10));

    receivePort.close();
    Isolate.exit();
  }
}

abstract class IsolateMsg {}

abstract class IsolateMsgRequest extends IsolateMsg {
  final SendPort? replySendPort;
  IsolateMsgRequest({this.replySendPort});
}

abstract class IsolateMsgResponse extends IsolateMsg {}

class IsolateMsgRequestExit extends IsolateMsgRequest {
  IsolateMsgRequestExit({super.replySendPort});
}

class IsolateMsgResponseExit extends IsolateMsgResponse {}

class IsolateException implements Exception {
  String exceptionMEssage;
  String? exceptionTrace;
  IsolateException(this.exceptionMEssage, this.exceptionTrace);

  String toString() {
    var report = exceptionMEssage;
    if (exceptionTrace != null) {
      report += '\n' + exceptionTrace!;
    }
    return report;
  }
}

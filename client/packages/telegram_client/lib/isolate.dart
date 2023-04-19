import 'dart:isolate';

import 'package:logging/logging.dart';

class Isolater {
  late final ReceivePort isolateReceivePort;
  late final Stream<dynamic> isolateReceivePortBroadcast;

  late SendPort isolateSendPort;

  Isolater() {
    isolateReceivePort = ReceivePort();
    isolateReceivePortBroadcast = isolateReceivePort.asBroadcastStream();
  }

  Future<void> spawn_(Isolated isolated, {String? debugName}) async {
    await Isolate.spawn(
      _entryPoint,
      IsolateSpawnMessage(isolated, isolateReceivePort.sendPort),
      debugName: debugName ?? runtimeType.toString(),
    );
    isolateSendPort = await isolateReceivePortBroadcast.first;
  }

  static void _entryPoint(IsolateSpawnMessage isolateSpawnMessage) {
    hierarchicalLoggingEnabled = true;
    isolateSpawnMessage.isolated.init(isolateSpawnMessage.parentSendPort);
  }

  Future<void> exit() async {
    isolateSendPort.send(IsolateMsgRequestExit(
      replySendPort: isolateReceivePort.sendPort,
    ));
    await isolateReceivePortBroadcast
        .firstWhere((element) => element is IsolateMsgResponseExit);
    isolateReceivePort.close();
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

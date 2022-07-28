import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';
import 'package:uuid/uuid.dart';

abstract class TelegramEventGenerator {
  void addEventListener(TelegramEventListener telegramEventListener);
  void removeEventListener(TelegramEventListener telegramEventListener);

  void exit() {}
}

abstract class TelegramEventListener {
  late final String uniqueKey;
  TelegramEventListener() {
    uniqueKey = Uuid().v1();
  }
  void update(dynamic event);

  void exit() {}

  TelegramSend? telegramClient;

  void setTelegramClient(TelegramSend telegramClient) {
    this.telegramClient = telegramClient;
  }

  void send(TdFunction tdFunction) {
    telegramClient?.send(tdFunction);
  }
}

abstract class TelegramSend {
  void send(TdFunction tdFunction);
}

class AddEventListener {
  TelegramEventListener eventListener;
  AddEventListener(
    this.eventListener,
  );
}

class RemoveEventListener {
  TelegramEventListener eventListener;
  RemoveEventListener(
    this.eventListener,
  );
}

class SendPortEventListener extends TelegramEventListener {
  SendPort sendPort;
  SendPortEventListener({
    required this.sendPort,
  });

  @override
  void update(dynamic event) {
    sendPort.send(event);
  }
}

class UpdateEvent {
  dynamic event;
  UpdateEvent(
    this.event,
  );
}

class SetTelegramSend extends TelegramSend {
  SendPort sendPort;
  SetTelegramSend(this.sendPort);
  @override
  void send(TdFunction tdFunction) {
    sendPort.send(tdFunction);
  }
}

class IsolateExit {}

mixin Isolated on TelegramEventListener {
  late final ReceivePort _isolateReceivePort;
  late final Stream<dynamic> _isolateReceivePortBroadcast;
  SendPort? isolateSendPort;

  late final TelegramEventListener instance;
  late final Function(dynamic message, TelegramEventListener instance)
      messageHandler;

  void init(
      {required TelegramEventListener instance,
      Function(dynamic message, TelegramEventListener instance) messageHandler =
          Isolated.handleMessage}) {
    _isolateReceivePort = ReceivePort();
    _isolateReceivePortBroadcast = _isolateReceivePort.asBroadcastStream();
    // uniqueKey = Uuid().v1();

    this.instance = instance;
    this.messageHandler = messageHandler;
  }

  @override
  void update(dynamic event) {
    isolateSendPort?.send(UpdateEvent(event));
  }

  Future<void> spawn() async {
    await Isolate.spawn(
      Isolated._entryPoint,
      [instance, _isolateReceivePort.sendPort, messageHandler],
      debugName: instance.runtimeType.toString(),
    );

    isolateSendPort = await _isolateReceivePortBroadcast.first;

    _isolateReceivePortBroadcast.listen((event) {
      if (event is TdFunction) {
        telegramClient?.send(event);
      }
    });
  }

  static void _entryPoint(List<dynamic> initialSpawnMessage) {
    TelegramEventListener instance = initialSpawnMessage[0];
    SendPort parentSendPort = initialSpawnMessage[1];
    Function(dynamic message, TelegramEventListener instance) messageHandler =
        initialSpawnMessage[2];

    var receivePort = ReceivePort();
    parentSendPort.send(receivePort.sendPort);

    instance.setTelegramClient(SetTelegramSend(parentSendPort));

    receivePort.listen((message) {
      messageHandler(message, instance);
    });
  }

  static void handleMessage(dynamic message, TelegramEventListener instance) {
    if (message is UpdateEvent) {
      instance.update(message.event);
    } else if (message is IsolateExit) {
      Isolate.exit();
    }
  }

  @override
  void exit() {
    isolateSendPort?.send(IsolateExit());
    _isolateReceivePort.close();
  }
}

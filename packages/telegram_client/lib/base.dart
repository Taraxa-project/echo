import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';
import 'package:uuid/uuid.dart';
import 'package:logging/logging.dart';

import 'db/db.dart';

abstract class TelegramSender {
  void send(TdFunction tdFunction);
}

abstract class TelegramEventGenerator {
  void addEventListener(
    TelegramEventListener telegramEventListener, {
    bool Function(dynamic event) filter = TelegramEventGenerator.allEvents,
  });
  void removeEventListener(TelegramEventListener telegramEventListener);

  Future<void> exit() async {}

  static bool allEvents(dynamic event) => true;
}

abstract class TelegramEventListener {
  void onEvent(dynamic event);

  void exit() {}

  late final String uniqueKey;
  TelegramSender? telegramSender;
  IsolateDB? db;
  Logger? logger;

  TelegramEventListener({
    TelegramSender? this.telegramSender,
    IsolateDB? this.db,
    Logger? this.logger,
  }) {
    uniqueKey = Uuid().v1();
  }

  void setTelegramSender({TelegramSender? telegramSender}) {
    this.telegramSender = telegramSender;
  }

  void send(TdFunction tdFunction) {
    logger?.info('sending ${tdFunction.runtimeType}...');
    telegramSender?.send(tdFunction);
    logger?.info('sent ${tdFunction.runtimeType}.');
  }
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
  void onEvent(dynamic event) {
    sendPort.send(event);
  }
}

class UpdateEvent {
  dynamic event;
  UpdateEvent(
    this.event,
  );
}

class SendPortTelegramSender extends TelegramSender {
  SendPort sendPort;
  SendPortTelegramSender({
    required this.sendPort,
  });

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

    this.instance = instance;
    this.messageHandler = messageHandler;
  }

  @override
  void onEvent(dynamic event) {
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
        telegramSender?.send(event);
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

    instance.setTelegramSender(
      telegramSender: SendPortTelegramSender(
        sendPort: parentSendPort,
      ),
    );

    receivePort.listen((message) {
      messageHandler(message, instance);
    });
  }

  static void handleMessage(dynamic message, TelegramEventListener instance) {
    if (message is UpdateEvent) {
      instance.onEvent(message.event);
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

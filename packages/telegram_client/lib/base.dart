import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';

abstract class TelegramEventGenerator {
  void addeventListener(TelegramEventListener telegramEventListener);
  void removeEventListener(TelegramEventListener telegramEventListener);

  void exit() {}
}

abstract class TelegramEventListener {
  late String uniqueKey;
  void update(event);

  void exit() {}
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
  SendPortEventListener(
    String uniqueKey,
    this.sendPort,
  ) {
    this.uniqueKey = uniqueKey;
  }

  @override
  void update(event) {
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

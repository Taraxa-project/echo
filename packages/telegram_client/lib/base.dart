import 'dart:async';

// import 'package:td_json_client/td_json_client.dart';
// import 'package:telegram_client/client.dart';

abstract class Telegram {
  Stream<dynamic> get events;
  void send(TdFunction);

  Map<String, StreamSubscription> _subscriptions = {};

  void addConsumer(TelegramEventsConsumer telegramEventsConsumer) {
    _subscriptions[telegramEventsConsumer.key] = events.listen((event) {
      telegramEventsConsumer.update(event);
    });
  }

  void removeConsumer(TelegramEventsConsumer telegramEventsConsumer) {
    _subscriptions.remove(telegramEventsConsumer.key)?.cancel();
  }
}

abstract class TelegramEventsConsumer {
  String get key;

  void update(dynamic event);
}

// tg = Tg();
// c = C();
// c.subscribe(tg);
// c.unsubscribe(tg);

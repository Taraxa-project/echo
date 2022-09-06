import 'dart:isolate';

import 'package:td_json_client/td_json_client.dart';

import 'base.dart';

class NewMesssages extends TelegramEventListener {
  @override
  void onEvent(dynamic event) {
    if (event is UpdateNewMessage) {
      _onUpdateNewMessage(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  NewMesssages({
    TelegramSender? super.telegramSender,
  });

  void _onUpdateNewMessage(UpdateNewMessage updateNewMessage) {
    var content = updateNewMessage.message?.content;
    if (content is MessageText && content.text is FormattedText) {
      print('${content.text?.text}');
    }
  }

  void _onError(Error error) {
    print(error);
  }

  static bool isUpdateNewMessageEvent(dynamic event) {
    return event is UpdateNewMessage || event is Error;
  }

  static Future<NewMesssagesIsolated> isolate({
    TelegramSender? telegramSender,
  }) async {
    NewMesssagesIsolated instance = NewMesssagesIsolated(
      telegramSender: telegramSender,
    );
    await instance.spawn();
    return instance;
  }
}

class NewMesssagesIsolated extends NewMesssages with Isolated {
  NewMesssagesIsolated({TelegramSender? super.telegramSender}) {
    init(instance: NewMesssages());
  }
}

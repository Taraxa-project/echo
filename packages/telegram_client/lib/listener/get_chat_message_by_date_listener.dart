import 'package:td_json_client/td_json_client.dart';
import 'package:uuid/uuid.dart';
import 'package:telegram_client/wrap_id.dart';

import '../base.dart';

class GetChatMessageByDateListener extends TelegramEventListener {
  bool _done = false;
  String? extra;
  int chatId;

  @override
  void onEvent(dynamic event) {
    if (event.extra == extra) {
      _done = true;
    }

    if (event is Message) {
      _onMessage(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  int? messageId;

  GetChatMessageByDateListener({
    TelegramSender? super.telegramSender,
    super.logger,
    required this.chatId,
  });

  void _onMessage(Message message) {
    messageId = WrapId.unwrapMessageId(message.id);
    logger?.info('[$chatId] received ${message.runtimeType} '
        'with id $messageId.');
  }

  void _onError(Error error) {
    logger?.info('received ${error.runtimeType}: $error.');
  }

  Future<void> get_chat_message_by_date({
    required DateTime date,
  }) async {
    logger?.info('[$chatId] searching last message '
        'before ${date.toIso8601String()} in TG...');
    extra = Uuid().v1();
    send(GetChatMessageByDate(
      chat_id: WrapId.wrapChatId(chatId),
      date: date.millisecondsSinceEpoch ~/ 1000,
      extra: extra,
    ));

    while (true) {
      if (_done) {
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  // static Future<GetChatMessageByDateIsolated> isolate({
  //   TelegramSender? telegramSender,
  // }) async {
  //   GetChatMessageByDateIsolated instance =
  //       GetChatMessageByDateIsolated(telegramSender: telegramSender);
  //   await instance.spawn();
  //   return instance;
  // }
}

// class GetChatMessageByDateIsolated extends GetChatMessageByDate with Isolated {
//   GetChatMessageByDateIsolated({TelegramSender? super.telegramSender}) {
//     init(
//       instance: GetChatsInfo(),
//       messageHandler: GetChatMessageByDate.handleMessage,
//     );
//   }

//   @override
//   void listChats({required int limit}) {
//     isolateSendPort?.send(ListChats(limit: limit));
//   }

//   static void handleMessage(dynamic message, TelegramEventListener instance) {
//     if (message is ListChats) {
//       (instance as GetChatsInfo).listChats(limit: message.limit);
//     } else {
//       Isolated.handleMessage(message, instance);
//     }
//   }
// }

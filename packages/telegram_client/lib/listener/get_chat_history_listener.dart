import 'package:td_json_client/td_json_client.dart';
import 'package:uuid/uuid.dart';
import 'package:telegram_client/wrap_id.dart';

import '../base.dart';

class GetChatHistoryListener extends TelegramEventListener {
  bool _done = false;
  String? extra;
  int chatId;

  @override
  void onEvent(dynamic event) {
    if (event.extra == extra) {
      _done = true;
    }

    if (event is Messages) {
      _onMessages(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  GetChatHistoryListener({
    TelegramSender? super.telegramSender,
    super.logger,
    required this.chatId,
  });

  Messages? messages;

  void _onMessages(Messages messages) {
    logger?.info('[${chatId}] received ${messages.runtimeType}.');
    this.messages = messages;
  }

  void _onError(Error error) {
    logger?.info('received ${error.runtimeType}: $error.');
  }

  Future<void> get_chat_history({
    required int from_message_id,
    required int offset,
    required int limit,
    bool only_local = false,
  }) async {
    this.messages = null;

    logger?.info('[$chatId] geting chat history '
        'from message $from_message_id in TG...');
    extra = Uuid().v1();
    send(GetChatHistory(
      chat_id: WrapId.wrapChatId(chatId),
      from_message_id: WrapId.wrapMessageId(from_message_id),
      offset: offset,
      limit: limit,
      only_local: only_local,
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

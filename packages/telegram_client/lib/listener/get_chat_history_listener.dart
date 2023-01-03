import 'package:td_json_client/td_json_client.dart';

import 'package:telegram_client/db/db.dart';
import '../base.dart';

class GetChatHistoryListener extends TelegramEventListener {
  @override
  void onEvent(dynamic event) {
    if (event is Messages) {
      _onMessages(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  GetChatHistoryListener({TelegramSender? super.telegramSender});

  Messages? messages;

  void _onMessages(Messages messages) {
    this.messages = messages;
  }

  void _onError(Error error) {
    print(error);
  }

  void get_chat_history({
    required int chat_id,
    required int from_message_id,
    required int offset,
    required int limit,
    bool only_local = false,
  }) {
    this.messages = null;
    send(GetChatHistory(
      chat_id: chat_id,
      from_message_id: from_message_id,
      offset: offset,
      limit: limit,
      only_local: only_local,
    ));
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

import 'package:td_json_client/td_json_client.dart';

import '../base.dart';

class GetChatMessageByDateListener extends TelegramEventListener {
  @override
  void onEvent(dynamic event) {
    if (event is Message) {
      _onMessage(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  int? messageId;

  GetChatMessageByDateListener({
    TelegramSender? super.telegramSender,
  });

  void _onMessage(Message message) {
    print(message);
    messageId = message.id;
  }

  void _onError(Error error) {
    print(error);
  }

  void get_chat_message_by_date({
    required int chat_id,
    required DateTime date,
  }) {
    send(GetChatMessageByDate(
      chat_id: chat_id,
      date: date.millisecondsSinceEpoch ~/ 1000,
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

import 'package:td_json_client/td_json_client.dart';

import 'base.dart';

class GetChatList extends TelegramEventListener {
  @override
  void onEvent(dynamic event) {
    if (event is UpdateSupergroupFullInfo ||
        event is UpdateBasicGroupFullInfo ||
        event is UpdateUserFullInfo) {
      _onUpdateInfo(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  GetChatList({
    TelegramSender? super.telegramSender,
  });

  void _onUpdateInfo(dynamic info) {
    print(info);
  }

  void _onError(Error error) {
    print(error);
  }

  void listChats({required int limit}) {
    send(GetChats(limit: limit));
  }

  static Future<GetChatListIsolated> isolate({
    TelegramSender? telegramSender,
  }) async {
    GetChatListIsolated instance =
        GetChatListIsolated(telegramSender: telegramSender);
    await instance.spawn();
    return instance;
  }
}

class GetChatListIsolated extends GetChatList with Isolated {
  GetChatListIsolated({TelegramSender? super.telegramSender}) {
    init(
      instance: GetChatList(),
      messageHandler: GetChatListIsolated.handleMessage,
    );
  }

  @override
  void listChats({required int limit}) {
    isolateSendPort?.send(ListChats(limit: limit));
  }

  static void handleMessage(dynamic message, TelegramEventListener instance) {
    if (message is ListChats) {
      (instance as GetChatList).listChats(limit: message.limit);
    } else {
      Isolated.handleMessage(message, instance);
    }
  }
}

class ListChats {
  int limit;
  ListChats({
    required this.limit,
  });
}

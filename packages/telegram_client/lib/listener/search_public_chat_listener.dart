import 'package:td_json_client/td_json_client.dart';
import 'package:telegram_client/wrap_id.dart';

import '../base.dart';
import 'package:telegram_client/db/db.dart';

class SearchPublicChatListener extends TelegramEventListener {
  @override
  void onEvent(dynamic event) {
    if (event is Chat) {
      _onChat(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  String username;

  SearchPublicChatListener({
    TelegramSender? super.telegramSender,
    DB? super.db,
    required this.username,
  });

  void _onChat(Chat chat) {
    var id = WrapId.unwrapChatId(chat.id);
    if (id != null) {
      db?.updateChat(
        username,
        id,
        chat.title ?? '',
      );
    }
  }

  void _onError(Error error) {
    print(error);
  }

  void search_public_chat() {
    db?.addChat(username);

    send(SearchPublicChat(
      username: username,
    ));
  }
}

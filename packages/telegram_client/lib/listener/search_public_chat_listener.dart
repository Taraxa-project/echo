import 'package:td_json_client/td_json_client.dart';
import 'package:uuid/uuid.dart';
import 'package:telegram_client/wrap_id.dart';
import 'package:telegram_client/db/db.dart';

import '../base.dart';

class SearchPublicChatListener extends TelegramEventListener {
  bool _done = false;
  String? extra;

  @override
  Future<void> onEvent(dynamic event) async{
    if (event.extra == extra) {
      _done = true;
    }

    if (event is Chat) {
      await _onChat(event);
    } else if (event is Error) {
      _onError(event);
    }
  }

  String username;

  SearchPublicChatListener({
    TelegramSender? super.telegramSender,
    DB? super.db,
    required this.username,
    super.logger,
  });

  Future<void> _onChat(Chat chat) async{
    logger?.info('[$username] received ${chat.runtimeType} '
        'with id ${chat.id}.');
    var id = WrapId.unwrapChatId(chat.id);
    logger?.info('[$username] unwrapped id is $id.');

    if (id != null) {
      logger?.info('[$username] updating chat in db...');
      await db?.updateChat(
        username,
        id,
        chat.title ?? '',
      );
      logger?.info('[$username] updated chat in db.');
    }
  }

  void _onError(Error error) {
    logger?.info('received ${error.runtimeType}: $error.');
  }

  Future<void> search_public_chat() async {
    logger?.info('[$username] adding chat to db...');
    await db?.addChat(username);
    logger?.info('[$username] added chat to db.');

    logger?.info('[$username] searching public chat in TG...');
    extra = Uuid().v1();
    send(SearchPublicChat(
      username: username,
      extra: extra,
    ));

    while (true) {
      if (_done) {
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  static bool isChat(dynamic event) {
    return event is Chat || event is Error;
  }
}

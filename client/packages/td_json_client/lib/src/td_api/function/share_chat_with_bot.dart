import 'package:td_json_client/src/td_api/td.dart';

/// Shares a chat after pressing a keyboardButtonTypeRequestChat button with the bot
class ShareChatWithBot extends TdFunction {
  String get tdType => 'shareChatWithBot';
  String get tdReturnType => 'Ok';

  /// Identifier of the chat with the bot
  int53? chat_id;

  /// Identifier of the message with the button
  int53? message_id;

  /// Identifier of the button
  int32? button_id;

  /// Identifier of the shared chat
  int53? shared_chat_id;

  /// Pass true to check that the chat can be shared by the button instead of actually sharing it. Doesn't check bot_is_member and bot_administrator_rights restrictions.
  /// If the bot must be a member, then all chats from getGroupsInCommon and all chats, where the user can add the bot, are suitable. In the latter case the bot will be automatically added to the chat.
  /// If the bot must be an administrator, then all chats, where the bot already has requested rights or can be added to administrators by the user, are suitable. In the latter case the bot will be automatically granted requested rights
  Bool? only_check;

  ShareChatWithBot({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.button_id,
    this.shared_chat_id,
    this.only_check,
  });

  ShareChatWithBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    button_id = map['button_id'];
    shared_chat_id = map['shared_chat_id'];
    only_check = map['only_check'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'button_id': button_id?.toMap(skipNulls: skipNulls),
      'shared_chat_id': shared_chat_id?.toMap(skipNulls: skipNulls),
      'only_check': only_check?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

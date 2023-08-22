import 'package:td_json_client/src/td_api/td.dart';

/// Shares a user after pressing a keyboardButtonTypeRequestUser button with the bot
class ShareUserWithBot extends TdFunction {
  String get tdType => 'shareUserWithBot';
  String get tdReturnType => 'Ok';

  /// Identifier of the chat with the bot
  int53? chat_id;

  /// Identifier of the message with the button
  int53? message_id;

  /// Identifier of the button
  int32? button_id;

  /// Identifier of the shared user
  int53? shared_user_id;

  /// Pass true to check that the user can be shared by the button instead of actually sharing them
  Bool? only_check;

  ShareUserWithBot({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.button_id,
    this.shared_user_id,
    this.only_check,
  });

  ShareUserWithBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    button_id = map['button_id'];
    shared_user_id = map['shared_user_id'];
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
      'shared_user_id': shared_user_id?.toMap(skipNulls: skipNulls),
      'only_check': only_check?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

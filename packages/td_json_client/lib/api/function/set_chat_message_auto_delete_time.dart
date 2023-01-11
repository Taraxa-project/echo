import 'package:td_json_client/api/base.dart';


/// Changes the message auto-delete or self-destruct (for secret chats) time in a chat. Requires change_info administrator right in basic groups, supergroups and channels
/// Message auto-delete time can't be changed in a chat with the current user (Saved Messages) and the chat 777000 (Telegram).
class SetChatMessageAutoDeleteTime extends TdFunction {
  String get tdType => 'setChatMessageAutoDeleteTime';
  String get tdReturnType => 'Ok';


  /// Chat identifier
  int53? chat_id;

  /// New time value, in seconds; unless the chat is secret, it must be from 0 up to 365 * 86400 and be divisible by 86400. If 0, then messages aren't deleted automatically
  int32? message_auto_delete_time;

  SetChatMessageAutoDeleteTime({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_auto_delete_time,
  });

  SetChatMessageAutoDeleteTime.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_auto_delete_time = map['message_auto_delete_time'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_auto_delete_time': message_auto_delete_time?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

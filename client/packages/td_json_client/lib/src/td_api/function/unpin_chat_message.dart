import 'package:td_json_client/src/td_api/td.dart';

/// Removes a pinned message from a chat; requires can_pin_messages rights in the group or can_edit_messages rights in the channel
class UnpinChatMessage extends TdFunction {
  String get tdType => 'unpinChatMessage';
  String get tdReturnType => 'Ok';

  /// Identifier of the chat
  int53? chat_id;

  /// Identifier of the removed pinned message
  int53? message_id;

  UnpinChatMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  UnpinChatMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';


/// Removes all pinned messages from a forum topic; requires can_pin_messages rights in the supergroup
class UnpinAllMessageThreadMessages extends TdFunction {
  String get tdType => 'unpinAllMessageThreadMessages';
  String get tdReturnType => 'Ok';


  /// Identifier of the chat
  int53? chat_id;

  /// Message thread identifier in which messages will be unpinned
  int53? message_thread_id;

  UnpinAllMessageThreadMessages({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
  });

  UnpinAllMessageThreadMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

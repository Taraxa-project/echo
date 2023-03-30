import 'package:td_json_client/src/td_api/td.dart';

/// Toggles whether a topic is closed in a forum supergroup chat; requires can_manage_topics administrator right in the supergroup unless the user is creator of the topic
class ToggleForumTopicIsClosed extends TdFunction {
  String get tdType => 'toggleForumTopicIsClosed';
  String get tdReturnType => 'Ok';

  /// Identifier of the chat
  int53? chat_id;

  /// Message thread identifier of the forum topic
  int53? message_thread_id;

  /// Pass true to close the topic; pass false to reopen it
  Bool? is_closed;

  ToggleForumTopicIsClosed({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.is_closed,
  });

  ToggleForumTopicIsClosed.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    is_closed = map['is_closed'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'is_closed': is_closed?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

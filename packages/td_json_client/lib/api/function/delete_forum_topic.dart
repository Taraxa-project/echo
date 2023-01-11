import 'package:td_json_client/api/base.dart';


/// Deletes all messages in a forum topic; requires can_delete_messages administrator right in the supergroup unless the user is creator of the topic, the topic has no messages from other users and has at most 11 messages
class DeleteForumTopic extends TdFunction {
  String get tdType => 'deleteForumTopic';
  String get tdReturnType => 'Ok';


  /// Identifier of the chat
  int53? chat_id;

  /// Message thread identifier of the forum topic
  int53? message_thread_id;

  DeleteForumTopic({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
  });

  DeleteForumTopic.fromMap(Map<String, dynamic> map) {
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

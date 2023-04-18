import 'package:td_json_client/src/td_api/td.dart';

/// Changes the pinned state of a forum topic; requires can_manage_topics administrator right in the supergroup. There can be up to getOption("pinned_forum_topic_count_max") pinned forum topics
class ToggleForumTopicIsPinned extends TdFunction {
  String get tdType => 'toggleForumTopicIsPinned';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// Message thread identifier of the forum topic
  int53? message_thread_id;

  /// Pass true to pin the topic; pass false to unpin it
  Bool? is_pinned;

  ToggleForumTopicIsPinned({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.is_pinned,
  });

  ToggleForumTopicIsPinned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Changes the order of pinned forum topics
class SetPinnedForumTopics extends TdFunction {
  String get tdType => 'setPinnedForumTopics';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// The new list of pinned forum topics
  vector<int53>? message_thread_ids;

  SetPinnedForumTopics({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_ids,
  });

  SetPinnedForumTopics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_thread_ids'] != null) {
      message_thread_ids = [];
      for (var someValue in map['message_thread_ids']) {
        message_thread_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_ids': message_thread_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

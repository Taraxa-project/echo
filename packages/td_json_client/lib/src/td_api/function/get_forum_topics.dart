import 'package:td_json_client/src/td_api/td.dart';

/// Returns found forum topics in a forum chat. This is a temporary method for getting information about topic list from the server
class GetForumTopics extends TdFunction {
  String get tdType => 'getForumTopics';
  String get tdReturnType => 'ForumTopics';

  /// Identifier of the forum chat
  int53? chat_id;

  /// Query to search for in the forum topic's name
  string? query;

  /// The date starting from which the results need to be fetched. Use 0 or any date in the future to get results from the last topic
  int32? offset_date;

  /// The message identifier of the last message in the last found topic, or 0 for the first request
  int53? offset_message_id;

  /// The message thread identifier of the last found topic, or 0 for the first request
  int53? offset_message_thread_id;

  /// The maximum number of forum topics to be returned; up to 100. For optimal performance, the number of returned forum topics is chosen by TDLib and can be smaller than the specified limit
  int32? limit;

  GetForumTopics({
    super.extra,
    super.client_id,
    this.chat_id,
    this.query,
    this.offset_date,
    this.offset_message_id,
    this.offset_message_thread_id,
    this.limit,
  });

  GetForumTopics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    query = map['query'];
    offset_date = map['offset_date'];
    offset_message_id = map['offset_message_id'];
    offset_message_thread_id = map['offset_message_thread_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'offset_date': offset_date?.toMap(skipNulls: skipNulls),
      'offset_message_id': offset_message_id?.toMap(skipNulls: skipNulls),
      'offset_message_thread_id':
          offset_message_thread_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

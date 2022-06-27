import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_event_log_filters.dart';

class GetChatEventLog extends TdFunction {
  String get tdType => 'getChatEventLog';
  String get tdReturnType => 'ChatEvents';

  string? extra;
  int? client_id;
  int53? chat_id;
  string? query;
  int64? from_event_id;
  int32? limit;
  ChatEventLogFilters? filters;
  vector<int53>? user_ids;

  GetChatEventLog({
    this.extra,
    this.client_id,
    this.chat_id,
    this.query,
    this.from_event_id,
    this.limit,
    this.filters,
    this.user_ids,
  });

  GetChatEventLog.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    query = map['query'];
    from_event_id = map['from_event_id'];
    limit = map['limit'];
    filters = TdApiMap.fromMap(map['filters']) as ChatEventLogFilters;
    if (map['user_ids']) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'from_event_id': from_event_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'filters': filters?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

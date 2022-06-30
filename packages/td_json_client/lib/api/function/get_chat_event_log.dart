import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_event_log_filters.dart';


/// Returns a list of service actions taken by chat members and administrators in the last 48 hours. Available only for supergroups and channels. Requires administrator rights. Returns results in reverse chronological order (i. e., in order of decreasing event_id)
class GetChatEventLog extends TdFunction {
  String get tdType => 'getChatEventLog';
  String get tdReturnType => 'ChatEvents';


  /// Chat identifier 
  int53? chat_id;

  /// Search query by which to filter events 
  string? query;

  /// Identifier of an event from which to return results. Use 0 to get results from the latest events 
  int64? from_event_id;

  /// The maximum number of events to return; up to 100
  int32? limit;

  /// The types of events to return; pass null to get chat events of all types 
  ChatEventLogFilters? filters;

  /// User identifiers by which to filter events. By default, events relating to all users will be returned
  vector<int53>? user_ids;

  GetChatEventLog({
    super.extra,
    super.client_id,
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
    if (map['filters'] != null) {
      filters = TdApiMap.fromMap(map['filters']) as ChatEventLogFilters;
    }
    if (map['user_ids'] != null) {
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

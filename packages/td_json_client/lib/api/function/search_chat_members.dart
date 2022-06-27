import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_members_filter.dart';

class SearchChatMembers extends TdFunction {
  String get tdType => 'searchChatMembers';
  String get tdReturnType => 'ChatMembers';

  string? extra;
  int? client_id;
  int53? chat_id;
  string? query;
  int32? limit;
  ChatMembersFilter? filter;

  SearchChatMembers({
    this.extra,
    this.client_id,
    this.chat_id,
    this.query,
    this.limit,
    this.filter,
  });

  SearchChatMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    query = map['query'];
    limit = map['limit'];
    filter = TdApiMap.fromMap(map['filter']) as ChatMembersFilter;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

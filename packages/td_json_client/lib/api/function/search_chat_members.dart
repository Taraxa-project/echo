import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_members_filter.dart';


/// Searches for a specified query in the first name, last name and username of the members of a specified chat. Requires administrator rights in channels
class SearchChatMembers extends TdFunction {
  String get tdType => 'searchChatMembers';
  String get tdReturnType => 'ChatMembers';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  /// Query to search for
  string? query;

  /// The maximum number of users to be returned; up to 200
  int32? limit;

  /// The type of users to search for; pass null to search among all chat members
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

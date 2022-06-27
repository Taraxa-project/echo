import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';

class SearchSecretMessages extends TdFunction {
  String get tdType => 'searchSecretMessages';
  String get tdReturnType => 'FoundMessages';

  string? extra;
  int? client_id;
  int53? chat_id;
  string? query;
  string? offset;
  int32? limit;
  SearchMessagesFilter? filter;

  SearchSecretMessages({
    this.extra,
    this.client_id,
    this.chat_id,
    this.query,
    this.offset,
    this.limit,
    this.filter,
  });

  SearchSecretMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    query = map['query'];
    offset = map['offset'];
    limit = map['limit'];
    filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_list.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';

class SearchMessages extends TdFunction {
  String get tdType => 'searchMessages';
  String get tdReturnType => 'Messages';

  string? extra;
  int? client_id;
  ChatList? chat_list;
  string? query;
  int32? offset_date;
  int53? offset_chat_id;
  int53? offset_message_id;
  int32? limit;
  SearchMessagesFilter? filter;
  int32? min_date;
  int32? max_date;

  SearchMessages({
    this.extra,
    this.client_id,
    this.chat_list,
    this.query,
    this.offset_date,
    this.offset_chat_id,
    this.offset_message_id,
    this.limit,
    this.filter,
    this.min_date,
    this.max_date,
  });

  SearchMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
    query = map['query'];
    offset_date = map['offset_date'];
    offset_chat_id = map['offset_chat_id'];
    offset_message_id = map['offset_message_id'];
    limit = map['limit'];
    filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    min_date = map['min_date'];
    max_date = map['max_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_list': chat_list?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'offset_date': offset_date?.toMap(skipNulls: skipNulls),
      'offset_chat_id': offset_chat_id?.toMap(skipNulls: skipNulls),
      'offset_message_id': offset_message_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'min_date': min_date?.toMap(skipNulls: skipNulls),
      'max_date': max_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

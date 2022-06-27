import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';

class SearchChatMessages extends TdFunction {
  String get tdType => 'searchChatMessages';
  String get tdReturnType => 'Messages';

  String? extra;
  int? client_id;
  int53? chat_id;
  string? query;
  MessageSender? sender_id;
  int53? from_message_id;
  int32? offset;
  int32? limit;
  SearchMessagesFilter? filter;
  int53? message_thread_id;

  SearchChatMessages({
    this.extra,
    this.client_id,
    this.chat_id,
    this.query,
    this.sender_id,
    this.from_message_id,
    this.offset,
    this.limit,
    this.filter,
    this.message_thread_id,
  });

  SearchChatMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    query = map['query'];
    sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    from_message_id = map['from_message_id'];
    offset = map['offset'];
    limit = map['limit'];
    filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    message_thread_id = map['message_thread_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
      'from_message_id': from_message_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

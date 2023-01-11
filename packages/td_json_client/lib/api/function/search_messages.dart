import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_list.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';


/// Searches for messages in all chats except secret chats. Returns the results in reverse chronological order (i.e., in order of decreasing (date, chat_id, message_id)).
/// For optimal performance, the number of returned messages is chosen by TDLib and can be smaller than the specified limit
class SearchMessages extends TdFunction {
  String get tdType => 'searchMessages';
  String get tdReturnType => 'FoundMessages';


  /// Chat list in which to search messages; pass null to search in all chats regardless of their chat list. Only Main and Archive chat lists are supported
  ChatList? chat_list;

  /// Query to search for
  string? query;

  /// Offset of the first entry to return as received from the previous request; use empty string to get the first chunk of results
  string? offset;

  /// The maximum number of messages to be returned; up to 100. For optimal performance, the number of returned messages is chosen by TDLib and can be smaller than the specified limit
  int32? limit;

  /// Additional filter for messages to search; pass null to search for all messages. Filters searchMessagesFilterMention, searchMessagesFilterUnreadMention, searchMessagesFilterUnreadReaction, searchMessagesFilterFailedToSend, and searchMessagesFilterPinned are unsupported in this function
  SearchMessagesFilter? filter;

  /// If not 0, the minimum date of the messages to return
  int32? min_date;

  /// If not 0, the maximum date of the messages to return
  int32? max_date;

  SearchMessages({
    super.extra,
    super.client_id,
    this.chat_list,
    this.query,
    this.offset,
    this.limit,
    this.filter,
    this.min_date,
    this.max_date,
  });

  SearchMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_list'] != null) {
      chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
    }
    query = map['query'];
    offset = map['offset'];
    limit = map['limit'];
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    }
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
      'offset': offset?.toMap(skipNulls: skipNulls),
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

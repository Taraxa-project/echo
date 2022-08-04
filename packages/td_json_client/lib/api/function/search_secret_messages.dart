import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';


/// Searches for messages in secret chats. Returns the results in reverse chronological order. For optimal performance, the number of returned messages is chosen by TDLib
class SearchSecretMessages extends TdFunction {
  String get tdType => 'searchSecretMessages';
  String get tdReturnType => 'FoundMessages';


  /// Identifier of the chat in which to search. Specify 0 to search in all secret chats
  int53? chat_id;

  /// Query to search for. If empty, searchChatMessages must be used instead
  string? query;

  /// Offset of the first entry to return as received from the previous request; use empty string to get the first chunk of results
  string? offset;

  /// The maximum number of messages to be returned; up to 100. For optimal performance, the number of returned messages is chosen by TDLib and can be smaller than the specified limit
  int32? limit;

  /// Additional filter for messages to search; pass null to search for all messages
  SearchMessagesFilter? filter;

  SearchSecretMessages({
    super.extra,
    super.client_id,
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
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    }
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

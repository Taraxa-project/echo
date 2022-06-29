import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';


/// Searches for messages with given words in the chat. Returns the results in reverse chronological order, i.e. in order of decreasing message_id. Cannot be used in secret chats with a non-empty query
/// (searchSecretMessages must be used instead), or without an enabled message database. For optimal performance, the number of returned messages is chosen by TDLib and can be smaller than the specified limit
class SearchChatMessages extends TdFunction {
  String get tdType => 'searchChatMessages';
  String get tdReturnType => 'Messages';

  String? extra;
  int? client_id;

  /// Identifier of the chat in which to search messages
  int53? chat_id;

  /// Query to search for
  string? query;

  /// Identifier of the sender of messages to search for; pass null to search for messages from any sender. Not supported in secret chats
  MessageSender? sender_id;

  /// Identifier of the message starting from which history must be fetched; use 0 to get results from the last message
  int53? from_message_id;

  /// Specify 0 to get results from exactly the from_message_id or a negative offset to get the specified message and some newer messages
  int32? offset;

  /// The maximum number of messages to be returned; must be positive and can't be greater than 100. If the offset is negative, the limit must be greater than -offset. For optimal performance, the number of returned messages is chosen by TDLib and can be smaller than the specified limit
  int32? limit;

  /// Additional filter for messages to search; pass null to search for all messages
  SearchMessagesFilter? filter;

  /// If not 0, only messages in the specified thread will be returned; supergroups only
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
    if (map['sender_id'] != null) {
      sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    }
    from_message_id = map['from_message_id'];
    offset = map['offset'];
    limit = map['limit'];
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    }
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

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';


/// Returns sparse positions of messages of the specified type in the chat to be used for shared media scroll implementation. Returns the results in reverse chronological order (i.e., in order of decreasing message_id).
/// Cannot be used in secret chats or with searchMessagesFilterFailedToSend filter without an enabled message database
class GetChatSparseMessagePositions extends TdFunction {
  String get tdType => 'getChatSparseMessagePositions';
  String get tdReturnType => 'MessagePositions';


  /// Identifier of the chat in which to return information about message positions
  int53? chat_id;

  /// Filter for message content. Filters searchMessagesFilterEmpty, searchMessagesFilterMention, searchMessagesFilterUnreadMention, and searchMessagesFilterUnreadReaction are unsupported in this function
  SearchMessagesFilter? filter;

  /// The message identifier from which to return information about message positions
  int53? from_message_id;

  /// The expected number of message positions to be returned; 50-2000. A smaller number of positions can be returned, if there are not enough appropriate messages
  int32? limit;

  GetChatSparseMessagePositions({
    super.extra,
    super.client_id,
    this.chat_id,
    this.filter,
    this.from_message_id,
    this.limit,
  });

  GetChatSparseMessagePositions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    }
    from_message_id = map['from_message_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'from_message_id': from_message_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

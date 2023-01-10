import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';


/// Returns information about the next messages of the specified type in the chat split by days. Returns the results in reverse chronological order. Can return partial result for the last returned day. Behavior of this method depends on the value of the option "utc_time_offset"
class GetChatMessageCalendar extends TdFunction {
  String get tdType => 'getChatMessageCalendar';
  String get tdReturnType => 'MessageCalendar';


  /// Identifier of the chat in which to return information about messages
  int53? chat_id;

  /// Filter for message content. Filters searchMessagesFilterEmpty, searchMessagesFilterMention, searchMessagesFilterUnreadMention, and searchMessagesFilterUnreadReaction are unsupported in this function
  SearchMessagesFilter? filter;

  /// The message identifier from which to return information about messages; use 0 to get results from the last message
  int53? from_message_id;

  GetChatMessageCalendar({
    super.extra,
    super.client_id,
    this.chat_id,
    this.filter,
    this.from_message_id,
  });

  GetChatMessageCalendar.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    }
    from_message_id = map['from_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'from_message_id': from_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

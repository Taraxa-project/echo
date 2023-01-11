import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';


/// Returns approximate 1-based position of a message among messages, which can be found by the specified filter in the chat. Cannot be used in secret chats
class GetChatMessagePosition extends TdFunction {
  String get tdType => 'getChatMessagePosition';
  String get tdReturnType => 'Count';


  /// Identifier of the chat in which to find message position
  int53? chat_id;

  /// Message identifier
  int53? message_id;

  /// Filter for message content; searchMessagesFilterEmpty, searchMessagesFilterUnreadMention, searchMessagesFilterUnreadReaction, and searchMessagesFilterFailedToSend are unsupported in this function
  SearchMessagesFilter? filter;

  /// If not 0, only messages in the specified thread will be considered; supergroups only
  int53? message_thread_id;

  GetChatMessagePosition({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.filter,
    this.message_thread_id,
  });

  GetChatMessagePosition.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
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
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

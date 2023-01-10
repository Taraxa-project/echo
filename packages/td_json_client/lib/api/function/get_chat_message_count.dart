import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/search_messages_filter.dart';


/// Returns approximate number of messages of the specified type in the chat 
class GetChatMessageCount extends TdFunction {
  String get tdType => 'getChatMessageCount';
  String get tdReturnType => 'Count';


  /// Identifier of the chat in which to count messages 
  int53? chat_id;

  /// Filter for message content; searchMessagesFilterEmpty is unsupported in this function 
  SearchMessagesFilter? filter;

  /// Pass true to get the number of messages without sending network requests, or -1 if the number of messages is unknown locally
  Bool? return_local;

  GetChatMessageCount({
    super.extra,
    super.client_id,
    this.chat_id,
    this.filter,
    this.return_local,
  });

  GetChatMessageCount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['filter'] != null) {
      filter = TdApiMap.fromMap(map['filter']) as SearchMessagesFilter;
    }
    return_local = map['return_local'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'filter': filter?.toMap(skipNulls: skipNulls),
      'return_local': return_local?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

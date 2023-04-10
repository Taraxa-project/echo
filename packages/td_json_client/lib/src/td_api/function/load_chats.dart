import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_list.dart';

/// Loads more chats from a chat list. The loaded chats and their positions in the chat list will be sent through updates. Chats are sorted by the pair (chat.position.order, chat.id) in descending order. Returns a 404 error if all chats have been loaded
class LoadChats extends TdFunction {
  String get tdType => 'loadChats';
  String get tdReturnType => 'Ok';

  /// The chat list in which to load chats; pass null to load chats from the main chat list
  ChatList? chat_list;

  /// The maximum number of chats to be loaded. For optimal performance, the number of loaded chats is chosen by TDLib and can be smaller than the specified limit, even if the end of the list is not reached
  int32? limit;

  LoadChats({
    super.extra,
    super.client_id,
    this.chat_list,
    this.limit,
  });

  LoadChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_list'] != null) {
      chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
    }
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_list': chat_list?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

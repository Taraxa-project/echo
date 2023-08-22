import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_list.dart';

/// Traverse all chats in a chat list and marks all messages in the chats as read
class ReadChatList extends TdFunction {
  String get tdType => 'readChatList';
  String get tdReturnType => 'Ok';

  /// Chat list in which to mark all chats as read
  ChatList? chat_list;

  ReadChatList({
    super.extra,
    super.client_id,
    this.chat_list,
  });

  ReadChatList.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_list'] != null) {
      chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_list': chat_list?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

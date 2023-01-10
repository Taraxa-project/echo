import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_list.dart';


/// Changes the pinned state of a chat. There can be up to GetOption("pinned_chat_count_max")/GetOption("pinned_archived_chat_count_max") pinned non-secret chats and the same number of secret chats in the main/archive chat list. The limit can be increased with Telegram Premium
class ToggleChatIsPinned extends TdFunction {
  String get tdType => 'toggleChatIsPinned';
  String get tdReturnType => 'Ok';


  /// Chat list in which to change the pinned state of the chat 
  ChatList? chat_list;

  /// Chat identifier 
  int53? chat_id;

  /// Pass true to pin the chat; pass false to unpin it
  Bool? is_pinned;

  ToggleChatIsPinned({
    super.extra,
    super.client_id,
    this.chat_list,
    this.chat_id,
    this.is_pinned,
  });

  ToggleChatIsPinned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_list'] != null) {
      chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
    }
    chat_id = map['chat_id'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_list': chat_list?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

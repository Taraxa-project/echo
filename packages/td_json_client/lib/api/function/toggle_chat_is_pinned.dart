import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_list.dart';

class ToggleChatIsPinned extends TdFunction {
  String get tdType => 'toggleChatIsPinned';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  ChatList? chat_list;
  int53? chat_id;
  Bool? is_pinned;

  ToggleChatIsPinned({
    this.extra,
    this.client_id,
    this.chat_list,
    this.chat_id,
    this.is_pinned,
  });

  ToggleChatIsPinned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
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

import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_list.dart';

/// Contains a list of chat lists
class ChatLists extends TdObject {
  String get tdType => 'chatLists';

  /// List of chat lists
  vector<ChatList>? chat_lists;

  ChatLists({
    super.extra,
    super.client_id,
    this.chat_lists,
  });

  ChatLists.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_lists'] != null) {
      chat_lists = [];
      for (var someValue in map['chat_lists']) {
        if (someValue != null) {
          chat_lists?.add(TdApiMap.fromMap(someValue) as ChatList);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_lists': chat_lists?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

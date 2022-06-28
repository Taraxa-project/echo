import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_list.dart';


/// Contains a list of chat lists 
class ChatLists extends TdObject {
  String get tdType => 'chatLists';

  String? extra;
  int? client_id;

  /// List of chat lists
  vector<ChatList>? chat_lists;

  ChatLists({
    this.extra,
    this.client_id,
    this.chat_lists,
  });

  ChatLists.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_lists']) {
      chat_lists = [];
      for (var someValue in map['chat_lists']) {
        chat_lists?.add(TdApiMap.fromMap(someValue) as ChatList);
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

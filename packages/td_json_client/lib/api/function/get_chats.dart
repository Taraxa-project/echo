import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_list.dart';


/// Returns an ordered list of chats from the beginning of a chat list. For informational purposes only. Use loadChats and updates processing instead to maintain chat lists in a consistent state
class GetChats extends TdFunction {
  String get tdType => 'getChats';
  String get tdReturnType => 'Chats';

  String? extra;
  int? client_id;

  /// The chat list in which to return chats; pass null to get chats from the main chat list 
  ChatList? chat_list;

  /// The maximum number of chats to be returned
  int32? limit;

  GetChats({
    this.extra,
    this.client_id,
    this.chat_list,
    this.limit,
  });

  GetChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
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

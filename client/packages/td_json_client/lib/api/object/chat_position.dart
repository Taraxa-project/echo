import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_list.dart';
import 'package:td_json_client/api/object/chat_source.dart';


/// Describes a position of a chat in a chat list
class ChatPosition extends TdObject {
  String get tdType => 'chatPosition';


  /// The chat list
  ChatList? list;

  /// A parameter used to determine order of the chat in the chat list. Chats must be sorted by the pair (order, chat.id) in descending order
  int64? order;

  /// True, if the chat is pinned in the chat list
  Bool? is_pinned;

  /// Source of the chat in the chat list; may be null
  ChatSource? source;

  ChatPosition({
    super.extra,
    super.client_id,
    this.list,
    this.order,
    this.is_pinned,
    this.source,
  });

  ChatPosition.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['list'] != null) {
      list = TdApiMap.fromMap(map['list']) as ChatList;
    }
    order = map['order'];
    is_pinned = map['is_pinned'];
    if (map['source'] != null) {
      source = TdApiMap.fromMap(map['source']) as ChatSource;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'list': list?.toMap(skipNulls: skipNulls),
      'order': order?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
      'source': source?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

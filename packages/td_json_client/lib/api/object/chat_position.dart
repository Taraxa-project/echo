import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_list.dart';
import 'package:td_json_client/api/object/chat_source.dart';

class ChatPosition extends TdObject {
  String get tdType => 'chatPosition';

  String? extra;
  int? client_id;
  ChatList? list;
  int64? order;
  Bool? is_pinned;
  ChatSource? source;

  ChatPosition({
    this.extra,
    this.client_id,
    this.list,
    this.order,
    this.is_pinned,
    this.source,
  });

  ChatPosition.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    list = TdApiMap.fromMap(map['list']) as ChatList;
    order = map['order'];
    is_pinned = map['is_pinned'];
    source = TdApiMap.fromMap(map['source']) as ChatSource;
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

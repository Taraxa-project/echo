import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/top_chat_category.dart';

class GetTopChats extends TdFunction {
  String get tdType => 'getTopChats';
  String get tdReturnType => 'Chats';

  string? extra;
  int? client_id;
  TopChatCategory? category;
  int32? limit;

  GetTopChats({
    this.extra,
    this.client_id,
    this.category,
    this.limit,
  });

  GetTopChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    category = TdApiMap.fromMap(map['category']) as TopChatCategory;
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'category': category?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/top_chat_category.dart';


/// Returns a list of frequently used chats. Supported only if the chat info database is enabled 
class GetTopChats extends TdFunction {
  String get tdType => 'getTopChats';
  String get tdReturnType => 'Chats';

  String? extra;
  int? client_id;

  /// Category of chats to be returned 
  TopChatCategory? category;

  /// The maximum number of chats to be returned; up to 30
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
    if (map['category'] != null) {
      category = TdApiMap.fromMap(map['category']) as TopChatCategory;
    }
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

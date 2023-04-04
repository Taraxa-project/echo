import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/top_chat_category.dart';

/// Removes a chat from the list of frequently used chats. Supported only if the chat info database is enabled
class RemoveTopChat extends TdFunction {
  String get tdType => 'removeTopChat';
  String get tdReturnType => 'Ok';

  /// Category of frequently used chats
  TopChatCategory? category;

  /// Chat identifier
  int53? chat_id;

  RemoveTopChat({
    super.extra,
    super.client_id,
    this.category,
    this.chat_id,
  });

  RemoveTopChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['category'] != null) {
      category = TdApiMap.fromMap(map['category']) as TopChatCategory;
    }
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'category': category?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

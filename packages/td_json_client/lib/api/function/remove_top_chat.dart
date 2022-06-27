import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/top_chat_category.dart';

class RemoveTopChat extends TdFunction {
  String get tdType => 'removeTopChat';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  TopChatCategory? category;
  int53? chat_id;

  RemoveTopChat({
    this.extra,
    this.client_id,
    this.category,
    this.chat_id,
  });

  RemoveTopChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    category = TdApiMap.fromMap(map['category']) as TopChatCategory;
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

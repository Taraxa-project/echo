import 'package:td_json_client/api/base.dart';

class AddChatMembers extends TdFunction {
  String get tdType => 'addChatMembers';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  vector<int53>? user_ids;

  AddChatMembers({
    this.extra,
    this.client_id,
    this.chat_id,
    this.user_ids,
  });

  AddChatMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['user_ids']) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

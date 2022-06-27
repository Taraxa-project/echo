import 'package:td_json_client/api/base.dart';

class DeleteChatHistory extends TdFunction {
  String get tdType => 'deleteChatHistory';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  Bool? remove_from_chat_list;
  Bool? revoke;

  DeleteChatHistory({
    this.extra,
    this.client_id,
    this.chat_id,
    this.remove_from_chat_list,
    this.revoke,
  });

  DeleteChatHistory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    remove_from_chat_list = map['remove_from_chat_list'];
    revoke = map['revoke'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'remove_from_chat_list': remove_from_chat_list?.toMap(skipNulls: skipNulls),
      'revoke': revoke?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

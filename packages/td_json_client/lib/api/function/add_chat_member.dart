import 'package:td_json_client/api/base.dart';

class AddChatMember extends TdFunction {
  String get tdType => 'addChatMember';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? user_id;
  int32? forward_limit;

  AddChatMember({
    this.extra,
    this.client_id,
    this.chat_id,
    this.user_id,
    this.forward_limit,
  });

  AddChatMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    user_id = map['user_id'];
    forward_limit = map['forward_limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'forward_limit': forward_limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

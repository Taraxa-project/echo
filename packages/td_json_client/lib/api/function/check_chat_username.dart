import 'package:td_json_client/api/base.dart';

class CheckChatUsername extends TdFunction {
  String get tdType => 'checkChatUsername';
  String get tdReturnType => 'CheckChatUsernameResult';

  String? extra;
  int? client_id;
  int53? chat_id;
  string? username;

  CheckChatUsername({
    this.extra,
    this.client_id,
    this.chat_id,
    this.username,
  });

  CheckChatUsername.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    username = map['username'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

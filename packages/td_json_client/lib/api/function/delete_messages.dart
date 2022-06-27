import 'package:td_json_client/api/base.dart';

class DeleteMessages extends TdFunction {
  String get tdType => 'deleteMessages';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int53? chat_id;
  vector<int53>? message_ids;
  Bool? revoke;

  DeleteMessages({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_ids,
    this.revoke,
  });

  DeleteMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_ids']) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
    revoke = map['revoke'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
      'revoke': revoke?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

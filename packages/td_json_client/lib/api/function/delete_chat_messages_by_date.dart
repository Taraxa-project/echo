import 'package:td_json_client/api/base.dart';

class DeleteChatMessagesByDate extends TdFunction {
  String get tdType => 'deleteChatMessagesByDate';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int53? chat_id;
  int32? min_date;
  int32? max_date;
  Bool? revoke;

  DeleteChatMessagesByDate({
    this.extra,
    this.client_id,
    this.chat_id,
    this.min_date,
    this.max_date,
    this.revoke,
  });

  DeleteChatMessagesByDate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    min_date = map['min_date'];
    max_date = map['max_date'];
    revoke = map['revoke'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'min_date': min_date?.toMap(skipNulls: skipNulls),
      'max_date': max_date?.toMap(skipNulls: skipNulls),
      'revoke': revoke?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

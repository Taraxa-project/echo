import 'package:td_json_client/api/base.dart';

class GetMessage extends TdFunction {
  String get tdType => 'getMessage';
  String get tdReturnType => 'Message';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;

  GetMessage({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
  });

  GetMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
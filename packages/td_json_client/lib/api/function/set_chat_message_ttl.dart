import 'package:td_json_client/api/base.dart';

class SetChatMessageTtl extends TdFunction {
  String get tdType => 'setChatMessageTtl';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  int32? ttl;

  SetChatMessageTtl({
    this.extra,
    this.client_id,
    this.chat_id,
    this.ttl,
  });

  SetChatMessageTtl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    ttl = map['ttl'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'ttl': ttl?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

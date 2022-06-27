import 'package:td_json_client/api/base.dart';

class GetChatPinnedMessage extends TdFunction {
  String get tdType => 'getChatPinnedMessage';
  String get tdReturnType => 'Message';

  string? extra;
  int? client_id;
  int53? chat_id;

  GetChatPinnedMessage({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  GetChatPinnedMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
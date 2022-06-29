import 'package:td_json_client/api/base.dart';


/// Changes the message TTL in a chat. Requires can_delete_messages administrator right in basic groups, supergroups and channels
/// Message TTL can't be changed in a chat with the current user (Saved Messages) and the chat 777000 (Telegram)
class SetChatMessageTtl extends TdFunction {
  String get tdType => 'setChatMessageTtl';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New TTL value, in seconds; must be one of 0, 86400, 7 * 86400, or 31 * 86400 unless the chat is secret
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

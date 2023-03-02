import 'package:td_json_client/api/base.dart';


/// Changes the message TTL in a chat. Requires can_delete_messages administrator right in basic groups, supergroups and channels
/// Message TTL can't be changed in a chat with the current user (Saved Messages) and the chat 777000 (Telegram).
class SetChatMessageTtl extends TdFunction {
  String get tdType => 'setChatMessageTtl';
  String get tdReturnType => 'Ok';


  /// Chat identifier 
  int53? chat_id;

  /// New TTL value, in seconds; unless the chat is secret, it must be from 0 up to 365 * 86400 and be divisible by 86400
  int32? ttl;

  SetChatMessageTtl({
    super.extra,
    super.client_id,
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

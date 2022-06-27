import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class BanChatMember extends TdFunction {
  String get tdType => 'banChatMember';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  MessageSender? member_id;
  int32? banned_until_date;
  Bool? revoke_messages;

  BanChatMember({
    this.extra,
    this.client_id,
    this.chat_id,
    this.member_id,
    this.banned_until_date,
    this.revoke_messages,
  });

  BanChatMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
    banned_until_date = map['banned_until_date'];
    revoke_messages = map['revoke_messages'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'member_id': member_id?.toMap(skipNulls: skipNulls),
      'banned_until_date': banned_until_date?.toMap(skipNulls: skipNulls),
      'revoke_messages': revoke_messages?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

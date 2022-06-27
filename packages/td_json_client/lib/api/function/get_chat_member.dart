import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class GetChatMember extends TdFunction {
  String get tdType => 'getChatMember';
  String get tdReturnType => 'ChatMember';

  string? extra;
  int? client_id;
  int53? chat_id;
  MessageSender? member_id;

  GetChatMember({
    this.extra,
    this.client_id,
    this.chat_id,
    this.member_id,
  });

  GetChatMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'member_id': member_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

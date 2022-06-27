import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';

class ChatMember extends TdObject {
  String get tdType => 'chatMember';

  string? extra;
  int? client_id;
  MessageSender? member_id;
  int53? inviter_user_id;
  int32? joined_chat_date;
  ChatMemberStatus? status;

  ChatMember({
    this.extra,
    this.client_id,
    this.member_id,
    this.inviter_user_id,
    this.joined_chat_date,
    this.status,
  });

  ChatMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
    inviter_user_id = map['inviter_user_id'];
    joined_chat_date = map['joined_chat_date'];
    status = TdApiMap.fromMap(map['status']) as ChatMemberStatus;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'member_id': member_id?.toMap(skipNulls: skipNulls),
      'inviter_user_id': inviter_user_id?.toMap(skipNulls: skipNulls),
      'joined_chat_date': joined_chat_date?.toMap(skipNulls: skipNulls),
      'status': status?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

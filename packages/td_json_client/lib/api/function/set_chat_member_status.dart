import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';

class SetChatMemberStatus extends TdFunction {
  String get tdType => 'setChatMemberStatus';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int53? chat_id;
  MessageSender? member_id;
  ChatMemberStatus? status;

  SetChatMemberStatus({
    this.extra,
    this.client_id,
    this.chat_id,
    this.member_id,
    this.status,
  });

  SetChatMemberStatus.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
    status = TdApiMap.fromMap(map['status']) as ChatMemberStatus;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'member_id': member_id?.toMap(skipNulls: skipNulls),
      'status': status?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

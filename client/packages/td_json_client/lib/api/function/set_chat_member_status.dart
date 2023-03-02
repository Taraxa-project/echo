import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';

/// Changes the status of a chat member, needs appropriate privileges. This function is currently not suitable for transferring chat ownership; use transferChatOwnership instead. Use addChatMember or banChatMember if some additional parameters needs to be passed
class SetChatMemberStatus extends TdFunction {
  String get tdType => 'setChatMemberStatus';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// Member identifier. Chats can be only banned and unbanned in supergroups and channels
  MessageSender? member_id;

  /// The new status of the member in the chat
  ChatMemberStatus? status;

  SetChatMemberStatus({
    super.extra,
    super.client_id,
    this.chat_id,
    this.member_id,
    this.status,
  });

  SetChatMemberStatus.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['member_id'] != null) {
      member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
    }
    if (map['status'] != null) {
      status = TdApiMap.fromMap(map['status']) as ChatMemberStatus;
    }
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

import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Bans a member in a chat. Members can't be banned in private or secret chats. In supergroups and channels, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first
class BanChatMember extends TdFunction {
  String get tdType => 'banChatMember';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// Member identifier
  MessageSender? member_id;

  /// Point in time (Unix timestamp) when the user will be unbanned; 0 if never. If the user is banned for more than 366 days or for less than 30 seconds from the current time, the user is considered to be banned forever. Ignored in basic groups and if a chat is banned
  int32? banned_until_date;

  /// Pass true to delete all messages in the chat for the user that is being removed. Always true for supergroups and channels
  Bool? revoke_messages;

  BanChatMember({
    super.extra,
    super.client_id,
    this.chat_id,
    this.member_id,
    this.banned_until_date,
    this.revoke_messages,
  });

  BanChatMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['member_id'] != null) {
      member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
    }
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

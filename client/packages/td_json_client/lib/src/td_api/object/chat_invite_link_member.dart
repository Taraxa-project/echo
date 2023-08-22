import 'package:td_json_client/src/td_api/td.dart';

/// Describes a chat member joined a chat via an invite link
class ChatInviteLinkMember extends TdObject {
  String get tdType => 'chatInviteLinkMember';

  /// User identifier
  int53? user_id;

  /// Point in time (Unix timestamp) when the user joined the chat
  int32? joined_chat_date;

  /// True, if the user has joined the chat using an invite link for a chat folder
  Bool? via_chat_folder_invite_link;

  /// User identifier of the chat administrator, approved user join request
  int53? approver_user_id;

  ChatInviteLinkMember({
    super.extra,
    super.client_id,
    this.user_id,
    this.joined_chat_date,
    this.via_chat_folder_invite_link,
    this.approver_user_id,
  });

  ChatInviteLinkMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    joined_chat_date = map['joined_chat_date'];
    via_chat_folder_invite_link = map['via_chat_folder_invite_link'];
    approver_user_id = map['approver_user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'joined_chat_date': joined_chat_date?.toMap(skipNulls: skipNulls),
      'via_chat_folder_invite_link': via_chat_folder_invite_link?.toMap(skipNulls: skipNulls),
      'approver_user_id': approver_user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

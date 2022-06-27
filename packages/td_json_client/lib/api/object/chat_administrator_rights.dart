import 'package:td_json_client/api/base.dart';


/// Describes rights of the administrator
class ChatAdministratorRights extends TdObject {
  String get tdType => 'chatAdministratorRights';

  String? extra;
  int? client_id;

  /// True, if the administrator can get chat event log, get chat statistics, get message statistics in channels, get channel members, see anonymous administrators in supergroups and ignore slow mode. Implied by any other privilege; applicable to supergroups and channels only
  Bool? can_manage_chat;

  /// True, if the administrator can change the chat title, photo, and other settings
  Bool? can_change_info;

  /// True, if the administrator can create channel posts; applicable to channels only
  Bool? can_post_messages;

  /// True, if the administrator can edit messages of other users and pin messages; applicable to channels only
  Bool? can_edit_messages;

  /// True, if the administrator can delete messages of other users
  Bool? can_delete_messages;

  /// True, if the administrator can invite new users to the chat
  Bool? can_invite_users;

  /// True, if the administrator can restrict, ban, or unban chat members; always true for channels
  Bool? can_restrict_members;

  /// True, if the administrator can pin messages; applicable to basic groups and supergroups only
  Bool? can_pin_messages;

  /// True, if the administrator can add new administrators with a subset of their own privileges or demote administrators that were directly or indirectly promoted by them
  Bool? can_promote_members;

  /// True, if the administrator can manage video chats
  Bool? can_manage_video_chats;

  /// True, if the administrator isn't shown in the chat member list and sends messages anonymously; applicable to supergroups only
  Bool? is_anonymous;

  ChatAdministratorRights({
    this.extra,
    this.client_id,
    this.can_manage_chat,
    this.can_change_info,
    this.can_post_messages,
    this.can_edit_messages,
    this.can_delete_messages,
    this.can_invite_users,
    this.can_restrict_members,
    this.can_pin_messages,
    this.can_promote_members,
    this.can_manage_video_chats,
    this.is_anonymous,
  });

  ChatAdministratorRights.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    can_manage_chat = map['can_manage_chat'];
    can_change_info = map['can_change_info'];
    can_post_messages = map['can_post_messages'];
    can_edit_messages = map['can_edit_messages'];
    can_delete_messages = map['can_delete_messages'];
    can_invite_users = map['can_invite_users'];
    can_restrict_members = map['can_restrict_members'];
    can_pin_messages = map['can_pin_messages'];
    can_promote_members = map['can_promote_members'];
    can_manage_video_chats = map['can_manage_video_chats'];
    is_anonymous = map['is_anonymous'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'can_manage_chat': can_manage_chat?.toMap(skipNulls: skipNulls),
      'can_change_info': can_change_info?.toMap(skipNulls: skipNulls),
      'can_post_messages': can_post_messages?.toMap(skipNulls: skipNulls),
      'can_edit_messages': can_edit_messages?.toMap(skipNulls: skipNulls),
      'can_delete_messages': can_delete_messages?.toMap(skipNulls: skipNulls),
      'can_invite_users': can_invite_users?.toMap(skipNulls: skipNulls),
      'can_restrict_members': can_restrict_members?.toMap(skipNulls: skipNulls),
      'can_pin_messages': can_pin_messages?.toMap(skipNulls: skipNulls),
      'can_promote_members': can_promote_members?.toMap(skipNulls: skipNulls),
      'can_manage_video_chats': can_manage_video_chats?.toMap(skipNulls: skipNulls),
      'is_anonymous': is_anonymous?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';

class ChatAdministratorRights extends TdObject {
  String get tdType => 'chatAdministratorRights';

  string? extra;
  int? client_id;
  Bool? can_manage_chat;
  Bool? can_change_info;
  Bool? can_post_messages;
  Bool? can_edit_messages;
  Bool? can_delete_messages;
  Bool? can_invite_users;
  Bool? can_restrict_members;
  Bool? can_pin_messages;
  Bool? can_promote_members;
  Bool? can_manage_video_chats;
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

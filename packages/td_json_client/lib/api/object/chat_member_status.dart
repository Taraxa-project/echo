import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_permissions.dart';

abstract class ChatMemberStatus extends TdObject {}

class ChatMemberStatusCreator extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusCreator';

  string? extra;
  int? client_id;
  string? custom_title;
  Bool? is_anonymous;
  Bool? is_member;

  ChatMemberStatusCreator({
    this.extra,
    this.client_id,
    this.custom_title,
    this.is_anonymous,
    this.is_member,
  });

  ChatMemberStatusCreator.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    custom_title = map['custom_title'];
    is_anonymous = map['is_anonymous'];
    is_member = map['is_member'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'custom_title': custom_title?.toMap(skipNulls: skipNulls),
      'is_anonymous': is_anonymous?.toMap(skipNulls: skipNulls),
      'is_member': is_member?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ChatMemberStatusAdministrator extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusAdministrator';

  string? extra;
  int? client_id;
  string? custom_title;
  Bool? can_be_edited;
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

  ChatMemberStatusAdministrator({
    this.extra,
    this.client_id,
    this.custom_title,
    this.can_be_edited,
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

  ChatMemberStatusAdministrator.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    custom_title = map['custom_title'];
    can_be_edited = map['can_be_edited'];
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
      'custom_title': custom_title?.toMap(skipNulls: skipNulls),
      'can_be_edited': can_be_edited?.toMap(skipNulls: skipNulls),
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
class ChatMemberStatusMember extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusMember';

  string? extra;
  int? client_id;

  ChatMemberStatusMember({
    this.extra,
    this.client_id,
  });

  ChatMemberStatusMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ChatMemberStatusRestricted extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusRestricted';

  string? extra;
  int? client_id;
  Bool? is_member;
  int32? restricted_until_date;
  ChatPermissions? permissions;

  ChatMemberStatusRestricted({
    this.extra,
    this.client_id,
    this.is_member,
    this.restricted_until_date,
    this.permissions,
  });

  ChatMemberStatusRestricted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_member = map['is_member'];
    restricted_until_date = map['restricted_until_date'];
    permissions = TdApiMap.fromMap(map['permissions']) as ChatPermissions;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_member': is_member?.toMap(skipNulls: skipNulls),
      'restricted_until_date': restricted_until_date?.toMap(skipNulls: skipNulls),
      'permissions': permissions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ChatMemberStatusLeft extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusLeft';

  string? extra;
  int? client_id;

  ChatMemberStatusLeft({
    this.extra,
    this.client_id,
  });

  ChatMemberStatusLeft.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ChatMemberStatusBanned extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusBanned';

  string? extra;
  int? client_id;
  int32? banned_until_date;

  ChatMemberStatusBanned({
    this.extra,
    this.client_id,
    this.banned_until_date,
  });

  ChatMemberStatusBanned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    banned_until_date = map['banned_until_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'banned_until_date': banned_until_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

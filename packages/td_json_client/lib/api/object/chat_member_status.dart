import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_administrator_rights.dart';
import 'package:td_json_client/api/object/chat_permissions.dart';

/// Provides information about the status of a member in a chat
abstract class ChatMemberStatus extends TdObject {}


/// The user is the owner of the chat and has all the administrator privileges
class ChatMemberStatusCreator extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusCreator';

  String? extra;
  int? client_id;

  /// A custom title of the owner; 0-16 characters without emojis; applicable to supergroups only
  string? custom_title;

  /// True, if the creator isn't shown in the chat member list and sends messages anonymously; applicable to supergroups only
  Bool? is_anonymous;

  /// True, if the user is a member of the chat
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

/// The user is a member of the chat and has some additional privileges. In basic groups, administrators can edit and delete messages sent by others, add new members, ban unprivileged members, and manage video chats. In supergroups and channels, there are more detailed options for administrator privileges
class ChatMemberStatusAdministrator extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusAdministrator';

  String? extra;
  int? client_id;

  /// A custom title of the administrator; 0-16 characters without emojis; applicable to supergroups only
  string? custom_title;

  /// True, if the current user can edit the administrator privileges for the called user
  Bool? can_be_edited;

  /// Rights of the administrator
  ChatAdministratorRights? rights;

  ChatMemberStatusAdministrator({
    this.extra,
    this.client_id,
    this.custom_title,
    this.can_be_edited,
    this.rights,
  });

  ChatMemberStatusAdministrator.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    custom_title = map['custom_title'];
    can_be_edited = map['can_be_edited'];
    if (map['rights'] != null) {
      rights = TdApiMap.fromMap(map['rights']) as ChatAdministratorRights;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'custom_title': custom_title?.toMap(skipNulls: skipNulls),
      'can_be_edited': can_be_edited?.toMap(skipNulls: skipNulls),
      'rights': rights?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user is a member of the chat, without any additional privileges or restrictions
class ChatMemberStatusMember extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusMember';

  String? extra;
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

/// The user is under certain restrictions in the chat. Not supported in basic groups and channels
class ChatMemberStatusRestricted extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusRestricted';

  String? extra;
  int? client_id;

  /// True, if the user is a member of the chat
  Bool? is_member;

  /// Point in time (Unix timestamp) when restrictions will be lifted from the user; 0 if never. If the user is restricted for more than 366 days or for less than 30 seconds from the current time, the user is considered to be restricted forever
  int32? restricted_until_date;

  /// User permissions in the chat
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
    if (map['permissions'] != null) {
      permissions = TdApiMap.fromMap(map['permissions']) as ChatPermissions;
    }
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

/// The user or the chat is not a chat member
class ChatMemberStatusLeft extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusLeft';

  String? extra;
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

/// The user or the chat was banned (and hence is not a member of the chat). Implies the user can't return to the chat, view messages, or be used as a participant identifier to join a video chat of the chat
class ChatMemberStatusBanned extends ChatMemberStatus {
  String get tdType => 'chatMemberStatusBanned';

  String? extra;
  int? client_id;

  /// Point in time (Unix timestamp) when the user will be unbanned; 0 if never. If the user is banned for more than 366 days or for less than 30 seconds from the current time, the user is considered to be banned forever. Always 0 in basic groups
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

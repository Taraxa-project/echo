import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';
import 'package:td_json_client/api/object/chat_invite_link.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/chat_permissions.dart';
import 'package:td_json_client/api/object/chat_photo.dart';
import 'package:td_json_client/api/object/chat_location.dart';

/// Represents a chat event
abstract class ChatEventAction extends TdObject {
  ChatEventAction({super.extra, super.client_id});
}


/// A message was edited 
class ChatEventMessageEdited extends ChatEventAction {
  String get tdType => 'chatEventMessageEdited';


  /// The original message before the edit 
  Message? old_message;

  /// The message after it was edited
  Message? new_message;

  ChatEventMessageEdited({
    super.extra,
    super.client_id,
    this.old_message,
    this.new_message,
  });

  ChatEventMessageEdited.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['old_message'] != null) {
      old_message = TdApiMap.fromMap(map['old_message']) as Message;
    }
    if (map['new_message'] != null) {
      new_message = TdApiMap.fromMap(map['new_message']) as Message;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_message': old_message?.toMap(skipNulls: skipNulls),
      'new_message': new_message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message was deleted 
class ChatEventMessageDeleted extends ChatEventAction {
  String get tdType => 'chatEventMessageDeleted';


  /// Deleted message
  Message? message;

  ChatEventMessageDeleted({
    super.extra,
    super.client_id,
    this.message,
  });

  ChatEventMessageDeleted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as Message;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A poll in a message was stopped 
class ChatEventPollStopped extends ChatEventAction {
  String get tdType => 'chatEventPollStopped';


  /// The message with the poll
  Message? message;

  ChatEventPollStopped({
    super.extra,
    super.client_id,
    this.message,
  });

  ChatEventPollStopped.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as Message;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message was pinned 
class ChatEventMessagePinned extends ChatEventAction {
  String get tdType => 'chatEventMessagePinned';


  /// Pinned message
  Message? message;

  ChatEventMessagePinned({
    super.extra,
    super.client_id,
    this.message,
  });

  ChatEventMessagePinned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as Message;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message was unpinned 
class ChatEventMessageUnpinned extends ChatEventAction {
  String get tdType => 'chatEventMessageUnpinned';


  /// Unpinned message
  Message? message;

  ChatEventMessageUnpinned({
    super.extra,
    super.client_id,
    this.message,
  });

  ChatEventMessageUnpinned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as Message;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A new member joined the chat
class ChatEventMemberJoined extends ChatEventAction {
  String get tdType => 'chatEventMemberJoined';


  ChatEventMemberJoined({
    super.extra,
    super.client_id,
  });

  ChatEventMemberJoined.fromMap(Map<String, dynamic> map) {
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

/// A new member joined the chat via an invite link 
class ChatEventMemberJoinedByInviteLink extends ChatEventAction {
  String get tdType => 'chatEventMemberJoinedByInviteLink';


  /// Invite link used to join the chat
  ChatInviteLink? invite_link;

  ChatEventMemberJoinedByInviteLink({
    super.extra,
    super.client_id,
    this.invite_link,
  });

  ChatEventMemberJoinedByInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['invite_link'] != null) {
      invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A new member was accepted to the chat by an administrator 
class ChatEventMemberJoinedByRequest extends ChatEventAction {
  String get tdType => 'chatEventMemberJoinedByRequest';


  /// User identifier of the chat administrator, approved user join request 
  int53? approver_user_id;

  /// Invite link used to join the chat; may be null
  ChatInviteLink? invite_link;

  ChatEventMemberJoinedByRequest({
    super.extra,
    super.client_id,
    this.approver_user_id,
    this.invite_link,
  });

  ChatEventMemberJoinedByRequest.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    approver_user_id = map['approver_user_id'];
    if (map['invite_link'] != null) {
      invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'approver_user_id': approver_user_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A member left the chat
class ChatEventMemberLeft extends ChatEventAction {
  String get tdType => 'chatEventMemberLeft';


  ChatEventMemberLeft({
    super.extra,
    super.client_id,
  });

  ChatEventMemberLeft.fromMap(Map<String, dynamic> map) {
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

/// A new chat member was invited 
class ChatEventMemberInvited extends ChatEventAction {
  String get tdType => 'chatEventMemberInvited';


  /// New member user identifier 
  int53? user_id;

  /// New member status
  ChatMemberStatus? status;

  ChatEventMemberInvited({
    super.extra,
    super.client_id,
    this.user_id,
    this.status,
  });

  ChatEventMemberInvited.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    if (map['status'] != null) {
      status = TdApiMap.fromMap(map['status']) as ChatMemberStatus;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'status': status?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A chat member has gained/lost administrator status, or the list of their administrator privileges has changed 
class ChatEventMemberPromoted extends ChatEventAction {
  String get tdType => 'chatEventMemberPromoted';


  /// Affected chat member user identifier 
  int53? user_id;

  /// Previous status of the chat member 
  ChatMemberStatus? old_status;

  /// New status of the chat member
  ChatMemberStatus? new_status;

  ChatEventMemberPromoted({
    super.extra,
    super.client_id,
    this.user_id,
    this.old_status,
    this.new_status,
  });

  ChatEventMemberPromoted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    if (map['old_status'] != null) {
      old_status = TdApiMap.fromMap(map['old_status']) as ChatMemberStatus;
    }
    if (map['new_status'] != null) {
      new_status = TdApiMap.fromMap(map['new_status']) as ChatMemberStatus;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'old_status': old_status?.toMap(skipNulls: skipNulls),
      'new_status': new_status?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A chat member was restricted/unrestricted or banned/unbanned, or the list of their restrictions has changed 
class ChatEventMemberRestricted extends ChatEventAction {
  String get tdType => 'chatEventMemberRestricted';


  /// Affected chat member identifier 
  MessageSender? member_id;

  /// Previous status of the chat member 
  ChatMemberStatus? old_status;

  /// New status of the chat member
  ChatMemberStatus? new_status;

  ChatEventMemberRestricted({
    super.extra,
    super.client_id,
    this.member_id,
    this.old_status,
    this.new_status,
  });

  ChatEventMemberRestricted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['member_id'] != null) {
      member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
    }
    if (map['old_status'] != null) {
      old_status = TdApiMap.fromMap(map['old_status']) as ChatMemberStatus;
    }
    if (map['new_status'] != null) {
      new_status = TdApiMap.fromMap(map['new_status']) as ChatMemberStatus;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'member_id': member_id?.toMap(skipNulls: skipNulls),
      'old_status': old_status?.toMap(skipNulls: skipNulls),
      'new_status': new_status?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat title was changed 
class ChatEventTitleChanged extends ChatEventAction {
  String get tdType => 'chatEventTitleChanged';


  /// Previous chat title 
  string? old_title;

  /// New chat title
  string? new_title;

  ChatEventTitleChanged({
    super.extra,
    super.client_id,
    this.old_title,
    this.new_title,
  });

  ChatEventTitleChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_title = map['old_title'];
    new_title = map['new_title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_title': old_title?.toMap(skipNulls: skipNulls),
      'new_title': new_title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat permissions was changed 
class ChatEventPermissionsChanged extends ChatEventAction {
  String get tdType => 'chatEventPermissionsChanged';


  /// Previous chat permissions 
  ChatPermissions? old_permissions;

  /// New chat permissions
  ChatPermissions? new_permissions;

  ChatEventPermissionsChanged({
    super.extra,
    super.client_id,
    this.old_permissions,
    this.new_permissions,
  });

  ChatEventPermissionsChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['old_permissions'] != null) {
      old_permissions = TdApiMap.fromMap(map['old_permissions']) as ChatPermissions;
    }
    if (map['new_permissions'] != null) {
      new_permissions = TdApiMap.fromMap(map['new_permissions']) as ChatPermissions;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_permissions': old_permissions?.toMap(skipNulls: skipNulls),
      'new_permissions': new_permissions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat description was changed 
class ChatEventDescriptionChanged extends ChatEventAction {
  String get tdType => 'chatEventDescriptionChanged';


  /// Previous chat description 
  string? old_description;

  /// New chat description
  string? new_description;

  ChatEventDescriptionChanged({
    super.extra,
    super.client_id,
    this.old_description,
    this.new_description,
  });

  ChatEventDescriptionChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_description = map['old_description'];
    new_description = map['new_description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_description': old_description?.toMap(skipNulls: skipNulls),
      'new_description': new_description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat username was changed 
class ChatEventUsernameChanged extends ChatEventAction {
  String get tdType => 'chatEventUsernameChanged';


  /// Previous chat username 
  string? old_username;

  /// New chat username
  string? new_username;

  ChatEventUsernameChanged({
    super.extra,
    super.client_id,
    this.old_username,
    this.new_username,
  });

  ChatEventUsernameChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_username = map['old_username'];
    new_username = map['new_username'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_username': old_username?.toMap(skipNulls: skipNulls),
      'new_username': new_username?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat photo was changed 
class ChatEventPhotoChanged extends ChatEventAction {
  String get tdType => 'chatEventPhotoChanged';


  /// Previous chat photo value; may be null 
  ChatPhoto? old_photo;

  /// New chat photo value; may be null
  ChatPhoto? new_photo;

  ChatEventPhotoChanged({
    super.extra,
    super.client_id,
    this.old_photo,
    this.new_photo,
  });

  ChatEventPhotoChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['old_photo'] != null) {
      old_photo = TdApiMap.fromMap(map['old_photo']) as ChatPhoto;
    }
    if (map['new_photo'] != null) {
      new_photo = TdApiMap.fromMap(map['new_photo']) as ChatPhoto;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_photo': old_photo?.toMap(skipNulls: skipNulls),
      'new_photo': new_photo?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The can_invite_users permission of a supergroup chat was toggled 
class ChatEventInvitesToggled extends ChatEventAction {
  String get tdType => 'chatEventInvitesToggled';


  /// New value of can_invite_users permission
  Bool? can_invite_users;

  ChatEventInvitesToggled({
    super.extra,
    super.client_id,
    this.can_invite_users,
  });

  ChatEventInvitesToggled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    can_invite_users = map['can_invite_users'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'can_invite_users': can_invite_users?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The linked chat of a supergroup was changed 
class ChatEventLinkedChatChanged extends ChatEventAction {
  String get tdType => 'chatEventLinkedChatChanged';


  /// Previous supergroup linked chat identifier 
  int53? old_linked_chat_id;

  /// New supergroup linked chat identifier
  int53? new_linked_chat_id;

  ChatEventLinkedChatChanged({
    super.extra,
    super.client_id,
    this.old_linked_chat_id,
    this.new_linked_chat_id,
  });

  ChatEventLinkedChatChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_linked_chat_id = map['old_linked_chat_id'];
    new_linked_chat_id = map['new_linked_chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_linked_chat_id': old_linked_chat_id?.toMap(skipNulls: skipNulls),
      'new_linked_chat_id': new_linked_chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The slow_mode_delay setting of a supergroup was changed 
class ChatEventSlowModeDelayChanged extends ChatEventAction {
  String get tdType => 'chatEventSlowModeDelayChanged';


  /// Previous value of slow_mode_delay, in seconds 
  int32? old_slow_mode_delay;

  /// New value of slow_mode_delay, in seconds
  int32? new_slow_mode_delay;

  ChatEventSlowModeDelayChanged({
    super.extra,
    super.client_id,
    this.old_slow_mode_delay,
    this.new_slow_mode_delay,
  });

  ChatEventSlowModeDelayChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_slow_mode_delay = map['old_slow_mode_delay'];
    new_slow_mode_delay = map['new_slow_mode_delay'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_slow_mode_delay': old_slow_mode_delay?.toMap(skipNulls: skipNulls),
      'new_slow_mode_delay': new_slow_mode_delay?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The message TTL was changed 
class ChatEventMessageTtlChanged extends ChatEventAction {
  String get tdType => 'chatEventMessageTtlChanged';


  /// Previous value of message_ttl 
  int32? old_message_ttl;

  /// New value of message_ttl
  int32? new_message_ttl;

  ChatEventMessageTtlChanged({
    super.extra,
    super.client_id,
    this.old_message_ttl,
    this.new_message_ttl,
  });

  ChatEventMessageTtlChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_message_ttl = map['old_message_ttl'];
    new_message_ttl = map['new_message_ttl'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_message_ttl': old_message_ttl?.toMap(skipNulls: skipNulls),
      'new_message_ttl': new_message_ttl?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sign_messages setting of a channel was toggled 
class ChatEventSignMessagesToggled extends ChatEventAction {
  String get tdType => 'chatEventSignMessagesToggled';


  /// New value of sign_messages
  Bool? sign_messages;

  ChatEventSignMessagesToggled({
    super.extra,
    super.client_id,
    this.sign_messages,
  });

  ChatEventSignMessagesToggled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sign_messages = map['sign_messages'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sign_messages': sign_messages?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The has_protected_content setting of a channel was toggled 
class ChatEventHasProtectedContentToggled extends ChatEventAction {
  String get tdType => 'chatEventHasProtectedContentToggled';


  /// New value of has_protected_content
  Bool? has_protected_content;

  ChatEventHasProtectedContentToggled({
    super.extra,
    super.client_id,
    this.has_protected_content,
  });

  ChatEventHasProtectedContentToggled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    has_protected_content = map['has_protected_content'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'has_protected_content': has_protected_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The supergroup sticker set was changed 
class ChatEventStickerSetChanged extends ChatEventAction {
  String get tdType => 'chatEventStickerSetChanged';


  /// Previous identifier of the chat sticker set; 0 if none 
  int64? old_sticker_set_id;

  /// New identifier of the chat sticker set; 0 if none
  int64? new_sticker_set_id;

  ChatEventStickerSetChanged({
    super.extra,
    super.client_id,
    this.old_sticker_set_id,
    this.new_sticker_set_id,
  });

  ChatEventStickerSetChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_sticker_set_id = map['old_sticker_set_id'];
    new_sticker_set_id = map['new_sticker_set_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_sticker_set_id': old_sticker_set_id?.toMap(skipNulls: skipNulls),
      'new_sticker_set_id': new_sticker_set_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The supergroup location was changed 
class ChatEventLocationChanged extends ChatEventAction {
  String get tdType => 'chatEventLocationChanged';


  /// Previous location; may be null 
  ChatLocation? old_location;

  /// New location; may be null
  ChatLocation? new_location;

  ChatEventLocationChanged({
    super.extra,
    super.client_id,
    this.old_location,
    this.new_location,
  });

  ChatEventLocationChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['old_location'] != null) {
      old_location = TdApiMap.fromMap(map['old_location']) as ChatLocation;
    }
    if (map['new_location'] != null) {
      new_location = TdApiMap.fromMap(map['new_location']) as ChatLocation;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_location': old_location?.toMap(skipNulls: skipNulls),
      'new_location': new_location?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The is_all_history_available setting of a supergroup was toggled 
class ChatEventIsAllHistoryAvailableToggled extends ChatEventAction {
  String get tdType => 'chatEventIsAllHistoryAvailableToggled';


  /// New value of is_all_history_available
  Bool? is_all_history_available;

  ChatEventIsAllHistoryAvailableToggled({
    super.extra,
    super.client_id,
    this.is_all_history_available,
  });

  ChatEventIsAllHistoryAvailableToggled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_all_history_available = map['is_all_history_available'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_all_history_available': is_all_history_available?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A chat invite link was edited 
class ChatEventInviteLinkEdited extends ChatEventAction {
  String get tdType => 'chatEventInviteLinkEdited';


  /// Previous information about the invite link 
  ChatInviteLink? old_invite_link;

  /// New information about the invite link
  ChatInviteLink? new_invite_link;

  ChatEventInviteLinkEdited({
    super.extra,
    super.client_id,
    this.old_invite_link,
    this.new_invite_link,
  });

  ChatEventInviteLinkEdited.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['old_invite_link'] != null) {
      old_invite_link = TdApiMap.fromMap(map['old_invite_link']) as ChatInviteLink;
    }
    if (map['new_invite_link'] != null) {
      new_invite_link = TdApiMap.fromMap(map['new_invite_link']) as ChatInviteLink;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_invite_link': old_invite_link?.toMap(skipNulls: skipNulls),
      'new_invite_link': new_invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A chat invite link was revoked 
class ChatEventInviteLinkRevoked extends ChatEventAction {
  String get tdType => 'chatEventInviteLinkRevoked';


  /// The invite link
  ChatInviteLink? invite_link;

  ChatEventInviteLinkRevoked({
    super.extra,
    super.client_id,
    this.invite_link,
  });

  ChatEventInviteLinkRevoked.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['invite_link'] != null) {
      invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A revoked chat invite link was deleted 
class ChatEventInviteLinkDeleted extends ChatEventAction {
  String get tdType => 'chatEventInviteLinkDeleted';


  /// The invite link
  ChatInviteLink? invite_link;

  ChatEventInviteLinkDeleted({
    super.extra,
    super.client_id,
    this.invite_link,
  });

  ChatEventInviteLinkDeleted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['invite_link'] != null) {
      invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video chat was created 
class ChatEventVideoChatCreated extends ChatEventAction {
  String get tdType => 'chatEventVideoChatCreated';


  /// Identifier of the video chat. The video chat can be received through the method getGroupCall
  int32? group_call_id;

  ChatEventVideoChatCreated({
    super.extra,
    super.client_id,
    this.group_call_id,
  });

  ChatEventVideoChatCreated.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video chat was ended 
class ChatEventVideoChatEnded extends ChatEventAction {
  String get tdType => 'chatEventVideoChatEnded';


  /// Identifier of the video chat. The video chat can be received through the method getGroupCall
  int32? group_call_id;

  ChatEventVideoChatEnded({
    super.extra,
    super.client_id,
    this.group_call_id,
  });

  ChatEventVideoChatEnded.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video chat participant was muted or unmuted 
class ChatEventVideoChatParticipantIsMutedToggled extends ChatEventAction {
  String get tdType => 'chatEventVideoChatParticipantIsMutedToggled';


  /// Identifier of the affected group call participant 
  MessageSender? participant_id;

  /// New value of is_muted
  Bool? is_muted;

  ChatEventVideoChatParticipantIsMutedToggled({
    super.extra,
    super.client_id,
    this.participant_id,
    this.is_muted,
  });

  ChatEventVideoChatParticipantIsMutedToggled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['participant_id'] != null) {
      participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
    }
    is_muted = map['is_muted'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'participant_id': participant_id?.toMap(skipNulls: skipNulls),
      'is_muted': is_muted?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video chat participant volume level was changed 
class ChatEventVideoChatParticipantVolumeLevelChanged extends ChatEventAction {
  String get tdType => 'chatEventVideoChatParticipantVolumeLevelChanged';


  /// Identifier of the affected group call participant 
  MessageSender? participant_id;

  /// New value of volume_level; 1-20000 in hundreds of percents
  int32? volume_level;

  ChatEventVideoChatParticipantVolumeLevelChanged({
    super.extra,
    super.client_id,
    this.participant_id,
    this.volume_level,
  });

  ChatEventVideoChatParticipantVolumeLevelChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['participant_id'] != null) {
      participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
    }
    volume_level = map['volume_level'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'participant_id': participant_id?.toMap(skipNulls: skipNulls),
      'volume_level': volume_level?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The mute_new_participants setting of a video chat was toggled 
class ChatEventVideoChatMuteNewParticipantsToggled extends ChatEventAction {
  String get tdType => 'chatEventVideoChatMuteNewParticipantsToggled';


  /// New value of the mute_new_participants setting
  Bool? mute_new_participants;

  ChatEventVideoChatMuteNewParticipantsToggled({
    super.extra,
    super.client_id,
    this.mute_new_participants,
  });

  ChatEventVideoChatMuteNewParticipantsToggled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    mute_new_participants = map['mute_new_participants'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'mute_new_participants': mute_new_participants?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

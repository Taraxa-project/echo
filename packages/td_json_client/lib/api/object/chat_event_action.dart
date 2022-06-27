import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';
import 'package:td_json_client/api/object/chat_invite_link.dart';
import 'package:td_json_client/api/object/chat_member_status.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/chat_location.dart';
import 'package:td_json_client/api/object/chat_permissions.dart';
import 'package:td_json_client/api/object/chat_photo.dart';

abstract class ChatEventAction extends TdObject {}

class ChatEventMessageEdited extends ChatEventAction {
  String get tdType => 'chatEventMessageEdited';

  string? extra;
  int? client_id;
  Message? old_message;
  Message? new_message;

  ChatEventMessageEdited({
    this.extra,
    this.client_id,
    this.old_message,
    this.new_message,
  });

  ChatEventMessageEdited.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_message = TdApiMap.fromMap(map['old_message']) as Message;
    new_message = TdApiMap.fromMap(map['new_message']) as Message;
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
class ChatEventMessageDeleted extends ChatEventAction {
  String get tdType => 'chatEventMessageDeleted';

  string? extra;
  int? client_id;
  Message? message;

  ChatEventMessageDeleted({
    this.extra,
    this.client_id,
    this.message,
  });

  ChatEventMessageDeleted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
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
class ChatEventMessagePinned extends ChatEventAction {
  String get tdType => 'chatEventMessagePinned';

  string? extra;
  int? client_id;
  Message? message;

  ChatEventMessagePinned({
    this.extra,
    this.client_id,
    this.message,
  });

  ChatEventMessagePinned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
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
class ChatEventMessageUnpinned extends ChatEventAction {
  String get tdType => 'chatEventMessageUnpinned';

  string? extra;
  int? client_id;
  Message? message;

  ChatEventMessageUnpinned({
    this.extra,
    this.client_id,
    this.message,
  });

  ChatEventMessageUnpinned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
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
class ChatEventPollStopped extends ChatEventAction {
  String get tdType => 'chatEventPollStopped';

  string? extra;
  int? client_id;
  Message? message;

  ChatEventPollStopped({
    this.extra,
    this.client_id,
    this.message,
  });

  ChatEventPollStopped.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
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
class ChatEventMemberJoined extends ChatEventAction {
  String get tdType => 'chatEventMemberJoined';

  string? extra;
  int? client_id;

  ChatEventMemberJoined({
    this.extra,
    this.client_id,
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
class ChatEventMemberJoinedByInviteLink extends ChatEventAction {
  String get tdType => 'chatEventMemberJoinedByInviteLink';

  string? extra;
  int? client_id;
  ChatInviteLink? invite_link;

  ChatEventMemberJoinedByInviteLink({
    this.extra,
    this.client_id,
    this.invite_link,
  });

  ChatEventMemberJoinedByInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
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
class ChatEventMemberJoinedByRequest extends ChatEventAction {
  String get tdType => 'chatEventMemberJoinedByRequest';

  string? extra;
  int? client_id;
  int53? approver_user_id;
  ChatInviteLink? invite_link;

  ChatEventMemberJoinedByRequest({
    this.extra,
    this.client_id,
    this.approver_user_id,
    this.invite_link,
  });

  ChatEventMemberJoinedByRequest.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    approver_user_id = map['approver_user_id'];
    invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
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
class ChatEventMemberInvited extends ChatEventAction {
  String get tdType => 'chatEventMemberInvited';

  string? extra;
  int? client_id;
  int53? user_id;
  ChatMemberStatus? status;

  ChatEventMemberInvited({
    this.extra,
    this.client_id,
    this.user_id,
    this.status,
  });

  ChatEventMemberInvited.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    status = TdApiMap.fromMap(map['status']) as ChatMemberStatus;
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
class ChatEventMemberLeft extends ChatEventAction {
  String get tdType => 'chatEventMemberLeft';

  string? extra;
  int? client_id;

  ChatEventMemberLeft({
    this.extra,
    this.client_id,
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
class ChatEventMemberPromoted extends ChatEventAction {
  String get tdType => 'chatEventMemberPromoted';

  string? extra;
  int? client_id;
  int53? user_id;
  ChatMemberStatus? old_status;
  ChatMemberStatus? new_status;

  ChatEventMemberPromoted({
    this.extra,
    this.client_id,
    this.user_id,
    this.old_status,
    this.new_status,
  });

  ChatEventMemberPromoted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    old_status = TdApiMap.fromMap(map['old_status']) as ChatMemberStatus;
    new_status = TdApiMap.fromMap(map['new_status']) as ChatMemberStatus;
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
class ChatEventMemberRestricted extends ChatEventAction {
  String get tdType => 'chatEventMemberRestricted';

  string? extra;
  int? client_id;
  MessageSender? member_id;
  ChatMemberStatus? old_status;
  ChatMemberStatus? new_status;

  ChatEventMemberRestricted({
    this.extra,
    this.client_id,
    this.member_id,
    this.old_status,
    this.new_status,
  });

  ChatEventMemberRestricted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    member_id = TdApiMap.fromMap(map['member_id']) as MessageSender;
    old_status = TdApiMap.fromMap(map['old_status']) as ChatMemberStatus;
    new_status = TdApiMap.fromMap(map['new_status']) as ChatMemberStatus;
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
class ChatEventAvailableReactionsChanged extends ChatEventAction {
  String get tdType => 'chatEventAvailableReactionsChanged';

  string? extra;
  int? client_id;
  vector<string>? old_available_reactions;
  vector<string>? new_available_reactions;

  ChatEventAvailableReactionsChanged({
    this.extra,
    this.client_id,
    this.old_available_reactions,
    this.new_available_reactions,
  });

  ChatEventAvailableReactionsChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['old_available_reactions']) {
      old_available_reactions = [];
      for (var someValue in map['old_available_reactions']) {
        old_available_reactions?.add(someValue);
      }
    }
    if (map['new_available_reactions']) {
      new_available_reactions = [];
      for (var someValue in map['new_available_reactions']) {
        new_available_reactions?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_available_reactions': old_available_reactions?.toMap(skipNulls: skipNulls),
      'new_available_reactions': new_available_reactions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class ChatEventDescriptionChanged extends ChatEventAction {
  String get tdType => 'chatEventDescriptionChanged';

  string? extra;
  int? client_id;
  string? old_description;
  string? new_description;

  ChatEventDescriptionChanged({
    this.extra,
    this.client_id,
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
class ChatEventLinkedChatChanged extends ChatEventAction {
  String get tdType => 'chatEventLinkedChatChanged';

  string? extra;
  int? client_id;
  int53? old_linked_chat_id;
  int53? new_linked_chat_id;

  ChatEventLinkedChatChanged({
    this.extra,
    this.client_id,
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
class ChatEventLocationChanged extends ChatEventAction {
  String get tdType => 'chatEventLocationChanged';

  string? extra;
  int? client_id;
  ChatLocation? old_location;
  ChatLocation? new_location;

  ChatEventLocationChanged({
    this.extra,
    this.client_id,
    this.old_location,
    this.new_location,
  });

  ChatEventLocationChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_location = TdApiMap.fromMap(map['old_location']) as ChatLocation;
    new_location = TdApiMap.fromMap(map['new_location']) as ChatLocation;
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
class ChatEventMessageTtlChanged extends ChatEventAction {
  String get tdType => 'chatEventMessageTtlChanged';

  string? extra;
  int? client_id;
  int32? old_message_ttl;
  int32? new_message_ttl;

  ChatEventMessageTtlChanged({
    this.extra,
    this.client_id,
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
class ChatEventPermissionsChanged extends ChatEventAction {
  String get tdType => 'chatEventPermissionsChanged';

  string? extra;
  int? client_id;
  ChatPermissions? old_permissions;
  ChatPermissions? new_permissions;

  ChatEventPermissionsChanged({
    this.extra,
    this.client_id,
    this.old_permissions,
    this.new_permissions,
  });

  ChatEventPermissionsChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_permissions = TdApiMap.fromMap(map['old_permissions']) as ChatPermissions;
    new_permissions = TdApiMap.fromMap(map['new_permissions']) as ChatPermissions;
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
class ChatEventPhotoChanged extends ChatEventAction {
  String get tdType => 'chatEventPhotoChanged';

  string? extra;
  int? client_id;
  ChatPhoto? old_photo;
  ChatPhoto? new_photo;

  ChatEventPhotoChanged({
    this.extra,
    this.client_id,
    this.old_photo,
    this.new_photo,
  });

  ChatEventPhotoChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_photo = TdApiMap.fromMap(map['old_photo']) as ChatPhoto;
    new_photo = TdApiMap.fromMap(map['new_photo']) as ChatPhoto;
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
class ChatEventSlowModeDelayChanged extends ChatEventAction {
  String get tdType => 'chatEventSlowModeDelayChanged';

  string? extra;
  int? client_id;
  int32? old_slow_mode_delay;
  int32? new_slow_mode_delay;

  ChatEventSlowModeDelayChanged({
    this.extra,
    this.client_id,
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
class ChatEventStickerSetChanged extends ChatEventAction {
  String get tdType => 'chatEventStickerSetChanged';

  string? extra;
  int? client_id;
  int64? old_sticker_set_id;
  int64? new_sticker_set_id;

  ChatEventStickerSetChanged({
    this.extra,
    this.client_id,
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
class ChatEventTitleChanged extends ChatEventAction {
  String get tdType => 'chatEventTitleChanged';

  string? extra;
  int? client_id;
  string? old_title;
  string? new_title;

  ChatEventTitleChanged({
    this.extra,
    this.client_id,
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
class ChatEventUsernameChanged extends ChatEventAction {
  String get tdType => 'chatEventUsernameChanged';

  string? extra;
  int? client_id;
  string? old_username;
  string? new_username;

  ChatEventUsernameChanged({
    this.extra,
    this.client_id,
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
class ChatEventHasProtectedContentToggled extends ChatEventAction {
  String get tdType => 'chatEventHasProtectedContentToggled';

  string? extra;
  int? client_id;
  Bool? has_protected_content;

  ChatEventHasProtectedContentToggled({
    this.extra,
    this.client_id,
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
class ChatEventInvitesToggled extends ChatEventAction {
  String get tdType => 'chatEventInvitesToggled';

  string? extra;
  int? client_id;
  Bool? can_invite_users;

  ChatEventInvitesToggled({
    this.extra,
    this.client_id,
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
class ChatEventIsAllHistoryAvailableToggled extends ChatEventAction {
  String get tdType => 'chatEventIsAllHistoryAvailableToggled';

  string? extra;
  int? client_id;
  Bool? is_all_history_available;

  ChatEventIsAllHistoryAvailableToggled({
    this.extra,
    this.client_id,
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
class ChatEventSignMessagesToggled extends ChatEventAction {
  String get tdType => 'chatEventSignMessagesToggled';

  string? extra;
  int? client_id;
  Bool? sign_messages;

  ChatEventSignMessagesToggled({
    this.extra,
    this.client_id,
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
class ChatEventInviteLinkEdited extends ChatEventAction {
  String get tdType => 'chatEventInviteLinkEdited';

  string? extra;
  int? client_id;
  ChatInviteLink? old_invite_link;
  ChatInviteLink? new_invite_link;

  ChatEventInviteLinkEdited({
    this.extra,
    this.client_id,
    this.old_invite_link,
    this.new_invite_link,
  });

  ChatEventInviteLinkEdited.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_invite_link = TdApiMap.fromMap(map['old_invite_link']) as ChatInviteLink;
    new_invite_link = TdApiMap.fromMap(map['new_invite_link']) as ChatInviteLink;
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
class ChatEventInviteLinkRevoked extends ChatEventAction {
  String get tdType => 'chatEventInviteLinkRevoked';

  string? extra;
  int? client_id;
  ChatInviteLink? invite_link;

  ChatEventInviteLinkRevoked({
    this.extra,
    this.client_id,
    this.invite_link,
  });

  ChatEventInviteLinkRevoked.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
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
class ChatEventInviteLinkDeleted extends ChatEventAction {
  String get tdType => 'chatEventInviteLinkDeleted';

  string? extra;
  int? client_id;
  ChatInviteLink? invite_link;

  ChatEventInviteLinkDeleted({
    this.extra,
    this.client_id,
    this.invite_link,
  });

  ChatEventInviteLinkDeleted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
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
class ChatEventVideoChatCreated extends ChatEventAction {
  String get tdType => 'chatEventVideoChatCreated';

  string? extra;
  int? client_id;
  int32? group_call_id;

  ChatEventVideoChatCreated({
    this.extra,
    this.client_id,
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
class ChatEventVideoChatEnded extends ChatEventAction {
  String get tdType => 'chatEventVideoChatEnded';

  string? extra;
  int? client_id;
  int32? group_call_id;

  ChatEventVideoChatEnded({
    this.extra,
    this.client_id,
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
class ChatEventVideoChatMuteNewParticipantsToggled extends ChatEventAction {
  String get tdType => 'chatEventVideoChatMuteNewParticipantsToggled';

  string? extra;
  int? client_id;
  Bool? mute_new_participants;

  ChatEventVideoChatMuteNewParticipantsToggled({
    this.extra,
    this.client_id,
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
class ChatEventVideoChatParticipantIsMutedToggled extends ChatEventAction {
  String get tdType => 'chatEventVideoChatParticipantIsMutedToggled';

  string? extra;
  int? client_id;
  MessageSender? participant_id;
  Bool? is_muted;

  ChatEventVideoChatParticipantIsMutedToggled({
    this.extra,
    this.client_id,
    this.participant_id,
    this.is_muted,
  });

  ChatEventVideoChatParticipantIsMutedToggled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
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
class ChatEventVideoChatParticipantVolumeLevelChanged extends ChatEventAction {
  String get tdType => 'chatEventVideoChatParticipantVolumeLevelChanged';

  string? extra;
  int? client_id;
  MessageSender? participant_id;
  int32? volume_level;

  ChatEventVideoChatParticipantVolumeLevelChanged({
    this.extra,
    this.client_id,
    this.participant_id,
    this.volume_level,
  });

  ChatEventVideoChatParticipantVolumeLevelChanged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
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

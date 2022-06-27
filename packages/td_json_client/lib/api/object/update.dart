import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/authorization_state.dart';
import 'package:td_json_client/api/object/message.dart';
import 'package:td_json_client/api/object/message_content.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/message_interaction_info.dart';
import 'package:td_json_client/api/object/unread_reaction.dart';
import 'package:td_json_client/api/object/chat.dart';
import 'package:td_json_client/api/object/chat_photo_info.dart';
import 'package:td_json_client/api/object/chat_permissions.dart';
import 'package:td_json_client/api/object/chat_position.dart';
import 'package:td_json_client/api/object/chat_action_bar.dart';
import 'package:td_json_client/api/object/draft_message.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/chat_notification_settings.dart';
import 'package:td_json_client/api/object/chat_join_requests_info.dart';
import 'package:td_json_client/api/object/video_chat.dart';
import 'package:td_json_client/api/object/chat_filter_info.dart';
import 'package:td_json_client/api/object/notification_settings_scope.dart';
import 'package:td_json_client/api/object/scope_notification_settings.dart';
import 'package:td_json_client/api/object/notification.dart';
import 'package:td_json_client/api/object/notification_group_type.dart';
import 'package:td_json_client/api/object/notification_group.dart';
import 'package:td_json_client/api/object/chat_action.dart';
import 'package:td_json_client/api/object/user_status.dart';
import 'package:td_json_client/api/object/user.dart';
import 'package:td_json_client/api/object/basic_group.dart';
import 'package:td_json_client/api/object/supergroup.dart';
import 'package:td_json_client/api/object/secret_chat.dart';
import 'package:td_json_client/api/object/user_full_info.dart';
import 'package:td_json_client/api/object/basic_group_full_info.dart';
import 'package:td_json_client/api/object/supergroup_full_info.dart';
import 'package:td_json_client/api/object/file.dart';
import 'package:td_json_client/api/object/file_download.dart';
import 'package:td_json_client/api/object/downloaded_file_counts.dart';
import 'package:td_json_client/api/object/call.dart';
import 'package:td_json_client/api/object/group_call.dart';
import 'package:td_json_client/api/object/group_call_participant.dart';
import 'package:td_json_client/api/object/user_privacy_setting.dart';
import 'package:td_json_client/api/object/user_privacy_setting_rules.dart';
import 'package:td_json_client/api/object/chat_list.dart';
import 'package:td_json_client/api/object/option_value.dart';
import 'package:td_json_client/api/object/sticker_set.dart';
import 'package:td_json_client/api/object/sticker_sets.dart';
import 'package:td_json_client/api/object/background.dart';
import 'package:td_json_client/api/object/chat_theme.dart';
import 'package:td_json_client/api/object/language_pack_string.dart';
import 'package:td_json_client/api/object/connection_state.dart';
import 'package:td_json_client/api/object/terms_of_service.dart';
import 'package:td_json_client/api/object/chat_nearby.dart';
import 'package:td_json_client/api/object/attachment_menu_bot.dart';
import 'package:td_json_client/api/object/reaction.dart';
import 'package:td_json_client/api/object/sticker.dart';
import 'package:td_json_client/api/object/suggested_action.dart';
import 'package:td_json_client/api/object/location.dart';
import 'package:td_json_client/api/object/chat_type.dart';
import 'package:td_json_client/api/object/callback_query_payload.dart';
import 'package:td_json_client/api/object/address.dart';
import 'package:td_json_client/api/object/order_info.dart';
import 'package:td_json_client/api/object/poll.dart';
import 'package:td_json_client/api/object/chat_invite_link.dart';
import 'package:td_json_client/api/object/chat_member.dart';
import 'package:td_json_client/api/object/chat_join_request.dart';

abstract class Update extends TdObject {}

class UpdateAuthorizationState extends Update {
  String get tdType => 'updateAuthorizationState';

  string? extra;
  int? client_id;
  AuthorizationState? authorization_state;

  UpdateAuthorizationState({
    this.extra,
    this.client_id,
    this.authorization_state,
  });

  UpdateAuthorizationState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    authorization_state = TdApiMap.fromMap(map['authorization_state']) as AuthorizationState;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'authorization_state': authorization_state?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewMessage extends Update {
  String get tdType => 'updateNewMessage';

  string? extra;
  int? client_id;
  Message? message;

  UpdateNewMessage({
    this.extra,
    this.client_id,
    this.message,
  });

  UpdateNewMessage.fromMap(Map<String, dynamic> map) {
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
class UpdateMessageSendAcknowledged extends Update {
  String get tdType => 'updateMessageSendAcknowledged';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;

  UpdateMessageSendAcknowledged({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
  });

  UpdateMessageSendAcknowledged.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageSendSucceeded extends Update {
  String get tdType => 'updateMessageSendSucceeded';

  string? extra;
  int? client_id;
  Message? message;
  int53? old_message_id;

  UpdateMessageSendSucceeded({
    this.extra,
    this.client_id,
    this.message,
    this.old_message_id,
  });

  UpdateMessageSendSucceeded.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
    old_message_id = map['old_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
      'old_message_id': old_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageSendFailed extends Update {
  String get tdType => 'updateMessageSendFailed';

  string? extra;
  int? client_id;
  Message? message;
  int53? old_message_id;
  int32? error_code;
  string? error_message;

  UpdateMessageSendFailed({
    this.extra,
    this.client_id,
    this.message,
    this.old_message_id,
    this.error_code,
    this.error_message,
  });

  UpdateMessageSendFailed.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
    old_message_id = map['old_message_id'];
    error_code = map['error_code'];
    error_message = map['error_message'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
      'old_message_id': old_message_id?.toMap(skipNulls: skipNulls),
      'error_code': error_code?.toMap(skipNulls: skipNulls),
      'error_message': error_message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageContent extends Update {
  String get tdType => 'updateMessageContent';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  MessageContent? new_content;

  UpdateMessageContent({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.new_content,
  });

  UpdateMessageContent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    new_content = TdApiMap.fromMap(map['new_content']) as MessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'new_content': new_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageEdited extends Update {
  String get tdType => 'updateMessageEdited';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  int32? edit_date;
  ReplyMarkup? reply_markup;

  UpdateMessageEdited({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.edit_date,
    this.reply_markup,
  });

  UpdateMessageEdited.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    edit_date = map['edit_date'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'edit_date': edit_date?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageIsPinned extends Update {
  String get tdType => 'updateMessageIsPinned';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  Bool? is_pinned;

  UpdateMessageIsPinned({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.is_pinned,
  });

  UpdateMessageIsPinned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageInteractionInfo extends Update {
  String get tdType => 'updateMessageInteractionInfo';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  MessageInteractionInfo? interaction_info;

  UpdateMessageInteractionInfo({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.interaction_info,
  });

  UpdateMessageInteractionInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    interaction_info = TdApiMap.fromMap(map['interaction_info']) as MessageInteractionInfo;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'interaction_info': interaction_info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageContentOpened extends Update {
  String get tdType => 'updateMessageContentOpened';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;

  UpdateMessageContentOpened({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
  });

  UpdateMessageContentOpened.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageMentionRead extends Update {
  String get tdType => 'updateMessageMentionRead';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  int32? unread_mention_count;

  UpdateMessageMentionRead({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.unread_mention_count,
  });

  UpdateMessageMentionRead.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    unread_mention_count = map['unread_mention_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'unread_mention_count': unread_mention_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageUnreadReactions extends Update {
  String get tdType => 'updateMessageUnreadReactions';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  vector<UnreadReaction>? unread_reactions;
  int32? unread_reaction_count;

  UpdateMessageUnreadReactions({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.unread_reactions,
    this.unread_reaction_count,
  });

  UpdateMessageUnreadReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['unread_reactions']) {
      unread_reactions = [];
      for (var someValue in map['unread_reactions']) {
        unread_reactions?.add(TdApiMap.fromMap(someValue) as UnreadReaction);
      }
    }
    unread_reaction_count = map['unread_reaction_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'unread_reactions': unread_reactions?.toMap(skipNulls: skipNulls),
      'unread_reaction_count': unread_reaction_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateMessageLiveLocationViewed extends Update {
  String get tdType => 'updateMessageLiveLocationViewed';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;

  UpdateMessageLiveLocationViewed({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
  });

  UpdateMessageLiveLocationViewed.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewChat extends Update {
  String get tdType => 'updateNewChat';

  string? extra;
  int? client_id;
  Chat? chat;

  UpdateNewChat({
    this.extra,
    this.client_id,
    this.chat,
  });

  UpdateNewChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat = TdApiMap.fromMap(map['chat']) as Chat;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat': chat?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatTitle extends Update {
  String get tdType => 'updateChatTitle';

  string? extra;
  int? client_id;
  int53? chat_id;
  string? title;

  UpdateChatTitle({
    this.extra,
    this.client_id,
    this.chat_id,
    this.title,
  });

  UpdateChatTitle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatPhoto extends Update {
  String get tdType => 'updateChatPhoto';

  string? extra;
  int? client_id;
  int53? chat_id;
  ChatPhotoInfo? photo;

  UpdateChatPhoto({
    this.extra,
    this.client_id,
    this.chat_id,
    this.photo,
  });

  UpdateChatPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    photo = TdApiMap.fromMap(map['photo']) as ChatPhotoInfo;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatPermissions extends Update {
  String get tdType => 'updateChatPermissions';

  string? extra;
  int? client_id;
  int53? chat_id;
  ChatPermissions? permissions;

  UpdateChatPermissions({
    this.extra,
    this.client_id,
    this.chat_id,
    this.permissions,
  });

  UpdateChatPermissions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    permissions = TdApiMap.fromMap(map['permissions']) as ChatPermissions;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'permissions': permissions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatLastMessage extends Update {
  String get tdType => 'updateChatLastMessage';

  string? extra;
  int? client_id;
  int53? chat_id;
  Message? last_message;
  vector<ChatPosition>? positions;

  UpdateChatLastMessage({
    this.extra,
    this.client_id,
    this.chat_id,
    this.last_message,
    this.positions,
  });

  UpdateChatLastMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    last_message = TdApiMap.fromMap(map['last_message']) as Message;
    if (map['positions']) {
      positions = [];
      for (var someValue in map['positions']) {
        positions?.add(TdApiMap.fromMap(someValue) as ChatPosition);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'last_message': last_message?.toMap(skipNulls: skipNulls),
      'positions': positions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatPosition extends Update {
  String get tdType => 'updateChatPosition';

  string? extra;
  int? client_id;
  int53? chat_id;
  ChatPosition? position;

  UpdateChatPosition({
    this.extra,
    this.client_id,
    this.chat_id,
    this.position,
  });

  UpdateChatPosition.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    position = TdApiMap.fromMap(map['position']) as ChatPosition;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'position': position?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatReadInbox extends Update {
  String get tdType => 'updateChatReadInbox';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? last_read_inbox_message_id;
  int32? unread_count;

  UpdateChatReadInbox({
    this.extra,
    this.client_id,
    this.chat_id,
    this.last_read_inbox_message_id,
    this.unread_count,
  });

  UpdateChatReadInbox.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    last_read_inbox_message_id = map['last_read_inbox_message_id'];
    unread_count = map['unread_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'last_read_inbox_message_id': last_read_inbox_message_id?.toMap(skipNulls: skipNulls),
      'unread_count': unread_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatReadOutbox extends Update {
  String get tdType => 'updateChatReadOutbox';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? last_read_outbox_message_id;

  UpdateChatReadOutbox({
    this.extra,
    this.client_id,
    this.chat_id,
    this.last_read_outbox_message_id,
  });

  UpdateChatReadOutbox.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    last_read_outbox_message_id = map['last_read_outbox_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'last_read_outbox_message_id': last_read_outbox_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatActionBar extends Update {
  String get tdType => 'updateChatActionBar';

  string? extra;
  int? client_id;
  int53? chat_id;
  ChatActionBar? action_bar;

  UpdateChatActionBar({
    this.extra,
    this.client_id,
    this.chat_id,
    this.action_bar,
  });

  UpdateChatActionBar.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    action_bar = TdApiMap.fromMap(map['action_bar']) as ChatActionBar;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'action_bar': action_bar?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatAvailableReactions extends Update {
  String get tdType => 'updateChatAvailableReactions';

  string? extra;
  int? client_id;
  int53? chat_id;
  vector<string>? available_reactions;

  UpdateChatAvailableReactions({
    this.extra,
    this.client_id,
    this.chat_id,
    this.available_reactions,
  });

  UpdateChatAvailableReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['available_reactions']) {
      available_reactions = [];
      for (var someValue in map['available_reactions']) {
        available_reactions?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'available_reactions': available_reactions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatDraftMessage extends Update {
  String get tdType => 'updateChatDraftMessage';

  string? extra;
  int? client_id;
  int53? chat_id;
  DraftMessage? draft_message;
  vector<ChatPosition>? positions;

  UpdateChatDraftMessage({
    this.extra,
    this.client_id,
    this.chat_id,
    this.draft_message,
    this.positions,
  });

  UpdateChatDraftMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    draft_message = TdApiMap.fromMap(map['draft_message']) as DraftMessage;
    if (map['positions']) {
      positions = [];
      for (var someValue in map['positions']) {
        positions?.add(TdApiMap.fromMap(someValue) as ChatPosition);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'draft_message': draft_message?.toMap(skipNulls: skipNulls),
      'positions': positions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatMessageSender extends Update {
  String get tdType => 'updateChatMessageSender';

  string? extra;
  int? client_id;
  int53? chat_id;
  MessageSender? message_sender_id;

  UpdateChatMessageSender({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_sender_id,
  });

  UpdateChatMessageSender.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_sender_id = TdApiMap.fromMap(map['message_sender_id']) as MessageSender;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_sender_id': message_sender_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatMessageTtl extends Update {
  String get tdType => 'updateChatMessageTtl';

  string? extra;
  int? client_id;
  int53? chat_id;
  int32? message_ttl;

  UpdateChatMessageTtl({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_ttl,
  });

  UpdateChatMessageTtl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_ttl = map['message_ttl'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_ttl': message_ttl?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatNotificationSettings extends Update {
  String get tdType => 'updateChatNotificationSettings';

  string? extra;
  int? client_id;
  int53? chat_id;
  ChatNotificationSettings? notification_settings;

  UpdateChatNotificationSettings({
    this.extra,
    this.client_id,
    this.chat_id,
    this.notification_settings,
  });

  UpdateChatNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    notification_settings = TdApiMap.fromMap(map['notification_settings']) as ChatNotificationSettings;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'notification_settings': notification_settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatPendingJoinRequests extends Update {
  String get tdType => 'updateChatPendingJoinRequests';

  string? extra;
  int? client_id;
  int53? chat_id;
  ChatJoinRequestsInfo? pending_join_requests;

  UpdateChatPendingJoinRequests({
    this.extra,
    this.client_id,
    this.chat_id,
    this.pending_join_requests,
  });

  UpdateChatPendingJoinRequests.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    pending_join_requests = TdApiMap.fromMap(map['pending_join_requests']) as ChatJoinRequestsInfo;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'pending_join_requests': pending_join_requests?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatReplyMarkup extends Update {
  String get tdType => 'updateChatReplyMarkup';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? reply_markup_message_id;

  UpdateChatReplyMarkup({
    this.extra,
    this.client_id,
    this.chat_id,
    this.reply_markup_message_id,
  });

  UpdateChatReplyMarkup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    reply_markup_message_id = map['reply_markup_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'reply_markup_message_id': reply_markup_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatTheme extends Update {
  String get tdType => 'updateChatTheme';

  string? extra;
  int? client_id;
  int53? chat_id;
  string? theme_name;

  UpdateChatTheme({
    this.extra,
    this.client_id,
    this.chat_id,
    this.theme_name,
  });

  UpdateChatTheme.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    theme_name = map['theme_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'theme_name': theme_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatUnreadMentionCount extends Update {
  String get tdType => 'updateChatUnreadMentionCount';

  string? extra;
  int? client_id;
  int53? chat_id;
  int32? unread_mention_count;

  UpdateChatUnreadMentionCount({
    this.extra,
    this.client_id,
    this.chat_id,
    this.unread_mention_count,
  });

  UpdateChatUnreadMentionCount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    unread_mention_count = map['unread_mention_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'unread_mention_count': unread_mention_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatUnreadReactionCount extends Update {
  String get tdType => 'updateChatUnreadReactionCount';

  string? extra;
  int? client_id;
  int53? chat_id;
  int32? unread_reaction_count;

  UpdateChatUnreadReactionCount({
    this.extra,
    this.client_id,
    this.chat_id,
    this.unread_reaction_count,
  });

  UpdateChatUnreadReactionCount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    unread_reaction_count = map['unread_reaction_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'unread_reaction_count': unread_reaction_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatVideoChat extends Update {
  String get tdType => 'updateChatVideoChat';

  string? extra;
  int? client_id;
  int53? chat_id;
  VideoChat? video_chat;

  UpdateChatVideoChat({
    this.extra,
    this.client_id,
    this.chat_id,
    this.video_chat,
  });

  UpdateChatVideoChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    video_chat = TdApiMap.fromMap(map['video_chat']) as VideoChat;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'video_chat': video_chat?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatDefaultDisableNotification extends Update {
  String get tdType => 'updateChatDefaultDisableNotification';

  string? extra;
  int? client_id;
  int53? chat_id;
  Bool? default_disable_notification;

  UpdateChatDefaultDisableNotification({
    this.extra,
    this.client_id,
    this.chat_id,
    this.default_disable_notification,
  });

  UpdateChatDefaultDisableNotification.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    default_disable_notification = map['default_disable_notification'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'default_disable_notification': default_disable_notification?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatHasProtectedContent extends Update {
  String get tdType => 'updateChatHasProtectedContent';

  string? extra;
  int? client_id;
  int53? chat_id;
  Bool? has_protected_content;

  UpdateChatHasProtectedContent({
    this.extra,
    this.client_id,
    this.chat_id,
    this.has_protected_content,
  });

  UpdateChatHasProtectedContent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    has_protected_content = map['has_protected_content'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'has_protected_content': has_protected_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatHasScheduledMessages extends Update {
  String get tdType => 'updateChatHasScheduledMessages';

  string? extra;
  int? client_id;
  int53? chat_id;
  Bool? has_scheduled_messages;

  UpdateChatHasScheduledMessages({
    this.extra,
    this.client_id,
    this.chat_id,
    this.has_scheduled_messages,
  });

  UpdateChatHasScheduledMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    has_scheduled_messages = map['has_scheduled_messages'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'has_scheduled_messages': has_scheduled_messages?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatIsBlocked extends Update {
  String get tdType => 'updateChatIsBlocked';

  string? extra;
  int? client_id;
  int53? chat_id;
  Bool? is_blocked;

  UpdateChatIsBlocked({
    this.extra,
    this.client_id,
    this.chat_id,
    this.is_blocked,
  });

  UpdateChatIsBlocked.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    is_blocked = map['is_blocked'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'is_blocked': is_blocked?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatIsMarkedAsUnread extends Update {
  String get tdType => 'updateChatIsMarkedAsUnread';

  string? extra;
  int? client_id;
  int53? chat_id;
  Bool? is_marked_as_unread;

  UpdateChatIsMarkedAsUnread({
    this.extra,
    this.client_id,
    this.chat_id,
    this.is_marked_as_unread,
  });

  UpdateChatIsMarkedAsUnread.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    is_marked_as_unread = map['is_marked_as_unread'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'is_marked_as_unread': is_marked_as_unread?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatFilters extends Update {
  String get tdType => 'updateChatFilters';

  string? extra;
  int? client_id;
  vector<ChatFilterInfo>? chat_filters;

  UpdateChatFilters({
    this.extra,
    this.client_id,
    this.chat_filters,
  });

  UpdateChatFilters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_filters']) {
      chat_filters = [];
      for (var someValue in map['chat_filters']) {
        chat_filters?.add(TdApiMap.fromMap(someValue) as ChatFilterInfo);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_filters': chat_filters?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatOnlineMemberCount extends Update {
  String get tdType => 'updateChatOnlineMemberCount';

  string? extra;
  int? client_id;
  int53? chat_id;
  int32? online_member_count;

  UpdateChatOnlineMemberCount({
    this.extra,
    this.client_id,
    this.chat_id,
    this.online_member_count,
  });

  UpdateChatOnlineMemberCount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    online_member_count = map['online_member_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'online_member_count': online_member_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateScopeNotificationSettings extends Update {
  String get tdType => 'updateScopeNotificationSettings';

  string? extra;
  int? client_id;
  NotificationSettingsScope? scope;
  ScopeNotificationSettings? notification_settings;

  UpdateScopeNotificationSettings({
    this.extra,
    this.client_id,
    this.scope,
    this.notification_settings,
  });

  UpdateScopeNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    scope = TdApiMap.fromMap(map['scope']) as NotificationSettingsScope;
    notification_settings = TdApiMap.fromMap(map['notification_settings']) as ScopeNotificationSettings;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'scope': scope?.toMap(skipNulls: skipNulls),
      'notification_settings': notification_settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNotification extends Update {
  String get tdType => 'updateNotification';

  string? extra;
  int? client_id;
  int32? notification_group_id;
  Notification? notification;

  UpdateNotification({
    this.extra,
    this.client_id,
    this.notification_group_id,
    this.notification,
  });

  UpdateNotification.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    notification_group_id = map['notification_group_id'];
    notification = TdApiMap.fromMap(map['notification']) as Notification;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'notification_group_id': notification_group_id?.toMap(skipNulls: skipNulls),
      'notification': notification?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNotificationGroup extends Update {
  String get tdType => 'updateNotificationGroup';

  string? extra;
  int? client_id;
  int32? notification_group_id;
  NotificationGroupType? type;
  int53? chat_id;
  int53? notification_settings_chat_id;
  int64? notification_sound_id;
  int32? total_count;
  vector<Notification>? added_notifications;
  vector<int32>? removed_notification_ids;

  UpdateNotificationGroup({
    this.extra,
    this.client_id,
    this.notification_group_id,
    this.type,
    this.chat_id,
    this.notification_settings_chat_id,
    this.notification_sound_id,
    this.total_count,
    this.added_notifications,
    this.removed_notification_ids,
  });

  UpdateNotificationGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    notification_group_id = map['notification_group_id'];
    type = TdApiMap.fromMap(map['type']) as NotificationGroupType;
    chat_id = map['chat_id'];
    notification_settings_chat_id = map['notification_settings_chat_id'];
    notification_sound_id = map['notification_sound_id'];
    total_count = map['total_count'];
    if (map['added_notifications']) {
      added_notifications = [];
      for (var someValue in map['added_notifications']) {
        added_notifications?.add(TdApiMap.fromMap(someValue) as Notification);
      }
    }
    if (map['removed_notification_ids']) {
      removed_notification_ids = [];
      for (var someValue in map['removed_notification_ids']) {
        removed_notification_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'notification_group_id': notification_group_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'notification_settings_chat_id': notification_settings_chat_id?.toMap(skipNulls: skipNulls),
      'notification_sound_id': notification_sound_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'added_notifications': added_notifications?.toMap(skipNulls: skipNulls),
      'removed_notification_ids': removed_notification_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateActiveNotifications extends Update {
  String get tdType => 'updateActiveNotifications';

  string? extra;
  int? client_id;
  vector<NotificationGroup>? groups;

  UpdateActiveNotifications({
    this.extra,
    this.client_id,
    this.groups,
  });

  UpdateActiveNotifications.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['groups']) {
      groups = [];
      for (var someValue in map['groups']) {
        groups?.add(TdApiMap.fromMap(someValue) as NotificationGroup);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'groups': groups?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateHavePendingNotifications extends Update {
  String get tdType => 'updateHavePendingNotifications';

  string? extra;
  int? client_id;
  Bool? have_delayed_notifications;
  Bool? have_unreceived_notifications;

  UpdateHavePendingNotifications({
    this.extra,
    this.client_id,
    this.have_delayed_notifications,
    this.have_unreceived_notifications,
  });

  UpdateHavePendingNotifications.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    have_delayed_notifications = map['have_delayed_notifications'];
    have_unreceived_notifications = map['have_unreceived_notifications'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'have_delayed_notifications': have_delayed_notifications?.toMap(skipNulls: skipNulls),
      'have_unreceived_notifications': have_unreceived_notifications?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateDeleteMessages extends Update {
  String get tdType => 'updateDeleteMessages';

  string? extra;
  int? client_id;
  int53? chat_id;
  vector<int53>? message_ids;
  Bool? is_permanent;
  Bool? from_cache;

  UpdateDeleteMessages({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_ids,
    this.is_permanent,
    this.from_cache,
  });

  UpdateDeleteMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_ids']) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
    is_permanent = map['is_permanent'];
    from_cache = map['from_cache'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
      'is_permanent': is_permanent?.toMap(skipNulls: skipNulls),
      'from_cache': from_cache?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatAction extends Update {
  String get tdType => 'updateChatAction';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_thread_id;
  MessageSender? sender_id;
  ChatAction? action;

  UpdateChatAction({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_thread_id,
    this.sender_id,
    this.action,
  });

  UpdateChatAction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    action = TdApiMap.fromMap(map['action']) as ChatAction;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
      'action': action?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateUserStatus extends Update {
  String get tdType => 'updateUserStatus';

  string? extra;
  int? client_id;
  int53? user_id;
  UserStatus? status;

  UpdateUserStatus({
    this.extra,
    this.client_id,
    this.user_id,
    this.status,
  });

  UpdateUserStatus.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    status = TdApiMap.fromMap(map['status']) as UserStatus;
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
class UpdateUser extends Update {
  String get tdType => 'updateUser';

  string? extra;
  int? client_id;
  User? user;

  UpdateUser({
    this.extra,
    this.client_id,
    this.user,
  });

  UpdateUser.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user = TdApiMap.fromMap(map['user']) as User;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user': user?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateBasicGroup extends Update {
  String get tdType => 'updateBasicGroup';

  string? extra;
  int? client_id;
  BasicGroup? basic_group;

  UpdateBasicGroup({
    this.extra,
    this.client_id,
    this.basic_group,
  });

  UpdateBasicGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    basic_group = TdApiMap.fromMap(map['basic_group']) as BasicGroup;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'basic_group': basic_group?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateSupergroup extends Update {
  String get tdType => 'updateSupergroup';

  string? extra;
  int? client_id;
  Supergroup? supergroup;

  UpdateSupergroup({
    this.extra,
    this.client_id,
    this.supergroup,
  });

  UpdateSupergroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup = TdApiMap.fromMap(map['supergroup']) as Supergroup;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup': supergroup?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateSecretChat extends Update {
  String get tdType => 'updateSecretChat';

  string? extra;
  int? client_id;
  SecretChat? secret_chat;

  UpdateSecretChat({
    this.extra,
    this.client_id,
    this.secret_chat,
  });

  UpdateSecretChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    secret_chat = TdApiMap.fromMap(map['secret_chat']) as SecretChat;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'secret_chat': secret_chat?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateUserFullInfo extends Update {
  String get tdType => 'updateUserFullInfo';

  string? extra;
  int? client_id;
  int53? user_id;
  UserFullInfo? user_full_info;

  UpdateUserFullInfo({
    this.extra,
    this.client_id,
    this.user_id,
    this.user_full_info,
  });

  UpdateUserFullInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    user_full_info = TdApiMap.fromMap(map['user_full_info']) as UserFullInfo;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'user_full_info': user_full_info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateBasicGroupFullInfo extends Update {
  String get tdType => 'updateBasicGroupFullInfo';

  string? extra;
  int? client_id;
  int53? basic_group_id;
  BasicGroupFullInfo? basic_group_full_info;

  UpdateBasicGroupFullInfo({
    this.extra,
    this.client_id,
    this.basic_group_id,
    this.basic_group_full_info,
  });

  UpdateBasicGroupFullInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    basic_group_id = map['basic_group_id'];
    basic_group_full_info = TdApiMap.fromMap(map['basic_group_full_info']) as BasicGroupFullInfo;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'basic_group_id': basic_group_id?.toMap(skipNulls: skipNulls),
      'basic_group_full_info': basic_group_full_info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateSupergroupFullInfo extends Update {
  String get tdType => 'updateSupergroupFullInfo';

  string? extra;
  int? client_id;
  int53? supergroup_id;
  SupergroupFullInfo? supergroup_full_info;

  UpdateSupergroupFullInfo({
    this.extra,
    this.client_id,
    this.supergroup_id,
    this.supergroup_full_info,
  });

  UpdateSupergroupFullInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    supergroup_full_info = TdApiMap.fromMap(map['supergroup_full_info']) as SupergroupFullInfo;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'supergroup_full_info': supergroup_full_info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateServiceNotification extends Update {
  String get tdType => 'updateServiceNotification';

  string? extra;
  int? client_id;
  string? type;
  MessageContent? content;

  UpdateServiceNotification({
    this.extra,
    this.client_id,
    this.type,
    this.content,
  });

  UpdateServiceNotification.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    type = map['type'];
    content = TdApiMap.fromMap(map['content']) as MessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'content': content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateFile extends Update {
  String get tdType => 'updateFile';

  string? extra;
  int? client_id;
  File? file;

  UpdateFile({
    this.extra,
    this.client_id,
    this.file,
  });

  UpdateFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file = TdApiMap.fromMap(map['file']) as File;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file': file?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateFileGenerationStart extends Update {
  String get tdType => 'updateFileGenerationStart';

  string? extra;
  int? client_id;
  int64? generation_id;
  string? original_path;
  string? destination_path;
  string? conversion;

  UpdateFileGenerationStart({
    this.extra,
    this.client_id,
    this.generation_id,
    this.original_path,
    this.destination_path,
    this.conversion,
  });

  UpdateFileGenerationStart.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    generation_id = map['generation_id'];
    original_path = map['original_path'];
    destination_path = map['destination_path'];
    conversion = map['conversion'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'generation_id': generation_id?.toMap(skipNulls: skipNulls),
      'original_path': original_path?.toMap(skipNulls: skipNulls),
      'destination_path': destination_path?.toMap(skipNulls: skipNulls),
      'conversion': conversion?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateFileGenerationStop extends Update {
  String get tdType => 'updateFileGenerationStop';

  string? extra;
  int? client_id;
  int64? generation_id;

  UpdateFileGenerationStop({
    this.extra,
    this.client_id,
    this.generation_id,
  });

  UpdateFileGenerationStop.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    generation_id = map['generation_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'generation_id': generation_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateFileDownloads extends Update {
  String get tdType => 'updateFileDownloads';

  string? extra;
  int? client_id;
  int53? total_size;
  int32? total_count;
  int53? downloaded_size;

  UpdateFileDownloads({
    this.extra,
    this.client_id,
    this.total_size,
    this.total_count,
    this.downloaded_size,
  });

  UpdateFileDownloads.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_size = map['total_size'];
    total_count = map['total_count'];
    downloaded_size = map['downloaded_size'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_size': total_size?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'downloaded_size': downloaded_size?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateFileAddedToDownloads extends Update {
  String get tdType => 'updateFileAddedToDownloads';

  string? extra;
  int? client_id;
  FileDownload? file_download;
  DownloadedFileCounts? counts;

  UpdateFileAddedToDownloads({
    this.extra,
    this.client_id,
    this.file_download,
    this.counts,
  });

  UpdateFileAddedToDownloads.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_download = TdApiMap.fromMap(map['file_download']) as FileDownload;
    counts = TdApiMap.fromMap(map['counts']) as DownloadedFileCounts;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_download': file_download?.toMap(skipNulls: skipNulls),
      'counts': counts?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateFileDownload extends Update {
  String get tdType => 'updateFileDownload';

  string? extra;
  int? client_id;
  int32? file_id;
  int32? complete_date;
  Bool? is_paused;
  DownloadedFileCounts? counts;

  UpdateFileDownload({
    this.extra,
    this.client_id,
    this.file_id,
    this.complete_date,
    this.is_paused,
    this.counts,
  });

  UpdateFileDownload.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    complete_date = map['complete_date'];
    is_paused = map['is_paused'];
    counts = TdApiMap.fromMap(map['counts']) as DownloadedFileCounts;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'complete_date': complete_date?.toMap(skipNulls: skipNulls),
      'is_paused': is_paused?.toMap(skipNulls: skipNulls),
      'counts': counts?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateFileRemovedFromDownloads extends Update {
  String get tdType => 'updateFileRemovedFromDownloads';

  string? extra;
  int? client_id;
  int32? file_id;
  DownloadedFileCounts? counts;

  UpdateFileRemovedFromDownloads({
    this.extra,
    this.client_id,
    this.file_id,
    this.counts,
  });

  UpdateFileRemovedFromDownloads.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    counts = TdApiMap.fromMap(map['counts']) as DownloadedFileCounts;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'counts': counts?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateCall extends Update {
  String get tdType => 'updateCall';

  string? extra;
  int? client_id;
  Call? call;

  UpdateCall({
    this.extra,
    this.client_id,
    this.call,
  });

  UpdateCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call = TdApiMap.fromMap(map['call']) as Call;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'call': call?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateGroupCall extends Update {
  String get tdType => 'updateGroupCall';

  string? extra;
  int? client_id;
  GroupCall? group_call;

  UpdateGroupCall({
    this.extra,
    this.client_id,
    this.group_call,
  });

  UpdateGroupCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call = TdApiMap.fromMap(map['group_call']) as GroupCall;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call': group_call?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateGroupCallParticipant extends Update {
  String get tdType => 'updateGroupCallParticipant';

  string? extra;
  int? client_id;
  int32? group_call_id;
  GroupCallParticipant? participant;

  UpdateGroupCallParticipant({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.participant,
  });

  UpdateGroupCallParticipant.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    participant = TdApiMap.fromMap(map['participant']) as GroupCallParticipant;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'participant': participant?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewCallSignalingData extends Update {
  String get tdType => 'updateNewCallSignalingData';

  string? extra;
  int? client_id;
  int32? call_id;
  bytes? data;

  UpdateNewCallSignalingData({
    this.extra,
    this.client_id,
    this.call_id,
    this.data,
  });

  UpdateNewCallSignalingData.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call_id = map['call_id'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'call_id': call_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateUserPrivacySettingRules extends Update {
  String get tdType => 'updateUserPrivacySettingRules';

  string? extra;
  int? client_id;
  UserPrivacySetting? setting;
  UserPrivacySettingRules? rules;

  UpdateUserPrivacySettingRules({
    this.extra,
    this.client_id,
    this.setting,
    this.rules,
  });

  UpdateUserPrivacySettingRules.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    setting = TdApiMap.fromMap(map['setting']) as UserPrivacySetting;
    rules = TdApiMap.fromMap(map['rules']) as UserPrivacySettingRules;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'setting': setting?.toMap(skipNulls: skipNulls),
      'rules': rules?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateUnreadMessageCount extends Update {
  String get tdType => 'updateUnreadMessageCount';

  string? extra;
  int? client_id;
  ChatList? chat_list;
  int32? unread_count;
  int32? unread_unmuted_count;

  UpdateUnreadMessageCount({
    this.extra,
    this.client_id,
    this.chat_list,
    this.unread_count,
    this.unread_unmuted_count,
  });

  UpdateUnreadMessageCount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
    unread_count = map['unread_count'];
    unread_unmuted_count = map['unread_unmuted_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_list': chat_list?.toMap(skipNulls: skipNulls),
      'unread_count': unread_count?.toMap(skipNulls: skipNulls),
      'unread_unmuted_count': unread_unmuted_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateUnreadChatCount extends Update {
  String get tdType => 'updateUnreadChatCount';

  string? extra;
  int? client_id;
  ChatList? chat_list;
  int32? total_count;
  int32? unread_count;
  int32? unread_unmuted_count;
  int32? marked_as_unread_count;
  int32? marked_as_unread_unmuted_count;

  UpdateUnreadChatCount({
    this.extra,
    this.client_id,
    this.chat_list,
    this.total_count,
    this.unread_count,
    this.unread_unmuted_count,
    this.marked_as_unread_count,
    this.marked_as_unread_unmuted_count,
  });

  UpdateUnreadChatCount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
    total_count = map['total_count'];
    unread_count = map['unread_count'];
    unread_unmuted_count = map['unread_unmuted_count'];
    marked_as_unread_count = map['marked_as_unread_count'];
    marked_as_unread_unmuted_count = map['marked_as_unread_unmuted_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_list': chat_list?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'unread_count': unread_count?.toMap(skipNulls: skipNulls),
      'unread_unmuted_count': unread_unmuted_count?.toMap(skipNulls: skipNulls),
      'marked_as_unread_count': marked_as_unread_count?.toMap(skipNulls: skipNulls),
      'marked_as_unread_unmuted_count': marked_as_unread_unmuted_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateOption extends Update {
  String get tdType => 'updateOption';

  string? extra;
  int? client_id;
  string? name;
  OptionValue? value;

  UpdateOption({
    this.extra,
    this.client_id,
    this.name,
    this.value,
  });

  UpdateOption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    value = TdApiMap.fromMap(map['value']) as OptionValue;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateStickerSet extends Update {
  String get tdType => 'updateStickerSet';

  string? extra;
  int? client_id;
  StickerSet? sticker_set;

  UpdateStickerSet({
    this.extra,
    this.client_id,
    this.sticker_set,
  });

  UpdateStickerSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker_set = TdApiMap.fromMap(map['sticker_set']) as StickerSet;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_set': sticker_set?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateInstalledStickerSets extends Update {
  String get tdType => 'updateInstalledStickerSets';

  string? extra;
  int? client_id;
  Bool? is_masks;
  vector<int64>? sticker_set_ids;

  UpdateInstalledStickerSets({
    this.extra,
    this.client_id,
    this.is_masks,
    this.sticker_set_ids,
  });

  UpdateInstalledStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_masks = map['is_masks'];
    if (map['sticker_set_ids']) {
      sticker_set_ids = [];
      for (var someValue in map['sticker_set_ids']) {
        sticker_set_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_masks': is_masks?.toMap(skipNulls: skipNulls),
      'sticker_set_ids': sticker_set_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateTrendingStickerSets extends Update {
  String get tdType => 'updateTrendingStickerSets';

  string? extra;
  int? client_id;
  StickerSets? sticker_sets;

  UpdateTrendingStickerSets({
    this.extra,
    this.client_id,
    this.sticker_sets,
  });

  UpdateTrendingStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker_sets = TdApiMap.fromMap(map['sticker_sets']) as StickerSets;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_sets': sticker_sets?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateRecentStickers extends Update {
  String get tdType => 'updateRecentStickers';

  string? extra;
  int? client_id;
  Bool? is_attached;
  vector<int32>? sticker_ids;

  UpdateRecentStickers({
    this.extra,
    this.client_id,
    this.is_attached,
    this.sticker_ids,
  });

  UpdateRecentStickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_attached = map['is_attached'];
    if (map['sticker_ids']) {
      sticker_ids = [];
      for (var someValue in map['sticker_ids']) {
        sticker_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_attached': is_attached?.toMap(skipNulls: skipNulls),
      'sticker_ids': sticker_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateFavoriteStickers extends Update {
  String get tdType => 'updateFavoriteStickers';

  string? extra;
  int? client_id;
  vector<int32>? sticker_ids;

  UpdateFavoriteStickers({
    this.extra,
    this.client_id,
    this.sticker_ids,
  });

  UpdateFavoriteStickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_ids']) {
      sticker_ids = [];
      for (var someValue in map['sticker_ids']) {
        sticker_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_ids': sticker_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateSavedAnimations extends Update {
  String get tdType => 'updateSavedAnimations';

  string? extra;
  int? client_id;
  vector<int32>? animation_ids;

  UpdateSavedAnimations({
    this.extra,
    this.client_id,
    this.animation_ids,
  });

  UpdateSavedAnimations.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['animation_ids']) {
      animation_ids = [];
      for (var someValue in map['animation_ids']) {
        animation_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'animation_ids': animation_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateSavedNotificationSounds extends Update {
  String get tdType => 'updateSavedNotificationSounds';

  string? extra;
  int? client_id;
  vector<int64>? notification_sound_ids;

  UpdateSavedNotificationSounds({
    this.extra,
    this.client_id,
    this.notification_sound_ids,
  });

  UpdateSavedNotificationSounds.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['notification_sound_ids']) {
      notification_sound_ids = [];
      for (var someValue in map['notification_sound_ids']) {
        notification_sound_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'notification_sound_ids': notification_sound_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateSelectedBackground extends Update {
  String get tdType => 'updateSelectedBackground';

  string? extra;
  int? client_id;
  Bool? for_dark_theme;
  Background? background;

  UpdateSelectedBackground({
    this.extra,
    this.client_id,
    this.for_dark_theme,
    this.background,
  });

  UpdateSelectedBackground.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    for_dark_theme = map['for_dark_theme'];
    background = TdApiMap.fromMap(map['background']) as Background;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'for_dark_theme': for_dark_theme?.toMap(skipNulls: skipNulls),
      'background': background?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatThemes extends Update {
  String get tdType => 'updateChatThemes';

  string? extra;
  int? client_id;
  vector<ChatTheme>? chat_themes;

  UpdateChatThemes({
    this.extra,
    this.client_id,
    this.chat_themes,
  });

  UpdateChatThemes.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_themes']) {
      chat_themes = [];
      for (var someValue in map['chat_themes']) {
        chat_themes?.add(TdApiMap.fromMap(someValue) as ChatTheme);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_themes': chat_themes?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateLanguagePackStrings extends Update {
  String get tdType => 'updateLanguagePackStrings';

  string? extra;
  int? client_id;
  string? localization_target;
  string? language_pack_id;
  vector<LanguagePackString>? strings;

  UpdateLanguagePackStrings({
    this.extra,
    this.client_id,
    this.localization_target,
    this.language_pack_id,
    this.strings,
  });

  UpdateLanguagePackStrings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    localization_target = map['localization_target'];
    language_pack_id = map['language_pack_id'];
    if (map['strings']) {
      strings = [];
      for (var someValue in map['strings']) {
        strings?.add(TdApiMap.fromMap(someValue) as LanguagePackString);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'localization_target': localization_target?.toMap(skipNulls: skipNulls),
      'language_pack_id': language_pack_id?.toMap(skipNulls: skipNulls),
      'strings': strings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateConnectionState extends Update {
  String get tdType => 'updateConnectionState';

  string? extra;
  int? client_id;
  ConnectionState? state;

  UpdateConnectionState({
    this.extra,
    this.client_id,
    this.state,
  });

  UpdateConnectionState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    state = TdApiMap.fromMap(map['state']) as ConnectionState;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'state': state?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateTermsOfService extends Update {
  String get tdType => 'updateTermsOfService';

  string? extra;
  int? client_id;
  string? terms_of_service_id;
  TermsOfService? terms_of_service;

  UpdateTermsOfService({
    this.extra,
    this.client_id,
    this.terms_of_service_id,
    this.terms_of_service,
  });

  UpdateTermsOfService.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    terms_of_service_id = map['terms_of_service_id'];
    terms_of_service = TdApiMap.fromMap(map['terms_of_service']) as TermsOfService;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'terms_of_service_id': terms_of_service_id?.toMap(skipNulls: skipNulls),
      'terms_of_service': terms_of_service?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateUsersNearby extends Update {
  String get tdType => 'updateUsersNearby';

  string? extra;
  int? client_id;
  vector<ChatNearby>? users_nearby;

  UpdateUsersNearby({
    this.extra,
    this.client_id,
    this.users_nearby,
  });

  UpdateUsersNearby.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['users_nearby']) {
      users_nearby = [];
      for (var someValue in map['users_nearby']) {
        users_nearby?.add(TdApiMap.fromMap(someValue) as ChatNearby);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'users_nearby': users_nearby?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateAttachmentMenuBots extends Update {
  String get tdType => 'updateAttachmentMenuBots';

  string? extra;
  int? client_id;
  vector<AttachmentMenuBot>? bots;

  UpdateAttachmentMenuBots({
    this.extra,
    this.client_id,
    this.bots,
  });

  UpdateAttachmentMenuBots.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['bots']) {
      bots = [];
      for (var someValue in map['bots']) {
        bots?.add(TdApiMap.fromMap(someValue) as AttachmentMenuBot);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bots': bots?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateWebAppMessageSent extends Update {
  String get tdType => 'updateWebAppMessageSent';

  string? extra;
  int? client_id;
  int64? web_app_launch_id;

  UpdateWebAppMessageSent({
    this.extra,
    this.client_id,
    this.web_app_launch_id,
  });

  UpdateWebAppMessageSent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    web_app_launch_id = map['web_app_launch_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'web_app_launch_id': web_app_launch_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateReactions extends Update {
  String get tdType => 'updateReactions';

  string? extra;
  int? client_id;
  vector<Reaction>? reactions;

  UpdateReactions({
    this.extra,
    this.client_id,
    this.reactions,
  });

  UpdateReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['reactions']) {
      reactions = [];
      for (var someValue in map['reactions']) {
        reactions?.add(TdApiMap.fromMap(someValue) as Reaction);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reactions': reactions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateDiceEmojis extends Update {
  String get tdType => 'updateDiceEmojis';

  string? extra;
  int? client_id;
  vector<string>? emojis;

  UpdateDiceEmojis({
    this.extra,
    this.client_id,
    this.emojis,
  });

  UpdateDiceEmojis.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['emojis']) {
      emojis = [];
      for (var someValue in map['emojis']) {
        emojis?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateAnimatedEmojiMessageClicked extends Update {
  String get tdType => 'updateAnimatedEmojiMessageClicked';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  Sticker? sticker;

  UpdateAnimatedEmojiMessageClicked({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.sticker,
  });

  UpdateAnimatedEmojiMessageClicked.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateAnimationSearchParameters extends Update {
  String get tdType => 'updateAnimationSearchParameters';

  string? extra;
  int? client_id;
  string? provider;
  vector<string>? emojis;

  UpdateAnimationSearchParameters({
    this.extra,
    this.client_id,
    this.provider,
    this.emojis,
  });

  UpdateAnimationSearchParameters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    provider = map['provider'];
    if (map['emojis']) {
      emojis = [];
      for (var someValue in map['emojis']) {
        emojis?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'provider': provider?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateSuggestedActions extends Update {
  String get tdType => 'updateSuggestedActions';

  string? extra;
  int? client_id;
  vector<SuggestedAction>? added_actions;
  vector<SuggestedAction>? removed_actions;

  UpdateSuggestedActions({
    this.extra,
    this.client_id,
    this.added_actions,
    this.removed_actions,
  });

  UpdateSuggestedActions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['added_actions']) {
      added_actions = [];
      for (var someValue in map['added_actions']) {
        added_actions?.add(TdApiMap.fromMap(someValue) as SuggestedAction);
      }
    }
    if (map['removed_actions']) {
      removed_actions = [];
      for (var someValue in map['removed_actions']) {
        removed_actions?.add(TdApiMap.fromMap(someValue) as SuggestedAction);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'added_actions': added_actions?.toMap(skipNulls: skipNulls),
      'removed_actions': removed_actions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewInlineQuery extends Update {
  String get tdType => 'updateNewInlineQuery';

  string? extra;
  int? client_id;
  int64? id;
  int53? sender_user_id;
  Location? user_location;
  ChatType? chat_type;
  string? query;
  string? offset;

  UpdateNewInlineQuery({
    this.extra,
    this.client_id,
    this.id,
    this.sender_user_id,
    this.user_location,
    this.chat_type,
    this.query,
    this.offset,
  });

  UpdateNewInlineQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    sender_user_id = map['sender_user_id'];
    user_location = TdApiMap.fromMap(map['user_location']) as Location;
    chat_type = TdApiMap.fromMap(map['chat_type']) as ChatType;
    query = map['query'];
    offset = map['offset'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'sender_user_id': sender_user_id?.toMap(skipNulls: skipNulls),
      'user_location': user_location?.toMap(skipNulls: skipNulls),
      'chat_type': chat_type?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewChosenInlineResult extends Update {
  String get tdType => 'updateNewChosenInlineResult';

  string? extra;
  int? client_id;
  int53? sender_user_id;
  Location? user_location;
  string? query;
  string? result_id;
  string? inline_message_id;

  UpdateNewChosenInlineResult({
    this.extra,
    this.client_id,
    this.sender_user_id,
    this.user_location,
    this.query,
    this.result_id,
    this.inline_message_id,
  });

  UpdateNewChosenInlineResult.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sender_user_id = map['sender_user_id'];
    user_location = TdApiMap.fromMap(map['user_location']) as Location;
    query = map['query'];
    result_id = map['result_id'];
    inline_message_id = map['inline_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sender_user_id': sender_user_id?.toMap(skipNulls: skipNulls),
      'user_location': user_location?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'result_id': result_id?.toMap(skipNulls: skipNulls),
      'inline_message_id': inline_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewCallbackQuery extends Update {
  String get tdType => 'updateNewCallbackQuery';

  string? extra;
  int? client_id;
  int64? id;
  int53? sender_user_id;
  int53? chat_id;
  int53? message_id;
  int64? chat_instance;
  CallbackQueryPayload? payload;

  UpdateNewCallbackQuery({
    this.extra,
    this.client_id,
    this.id,
    this.sender_user_id,
    this.chat_id,
    this.message_id,
    this.chat_instance,
    this.payload,
  });

  UpdateNewCallbackQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    sender_user_id = map['sender_user_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    chat_instance = map['chat_instance'];
    payload = TdApiMap.fromMap(map['payload']) as CallbackQueryPayload;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'sender_user_id': sender_user_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'chat_instance': chat_instance?.toMap(skipNulls: skipNulls),
      'payload': payload?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewInlineCallbackQuery extends Update {
  String get tdType => 'updateNewInlineCallbackQuery';

  string? extra;
  int? client_id;
  int64? id;
  int53? sender_user_id;
  string? inline_message_id;
  int64? chat_instance;
  CallbackQueryPayload? payload;

  UpdateNewInlineCallbackQuery({
    this.extra,
    this.client_id,
    this.id,
    this.sender_user_id,
    this.inline_message_id,
    this.chat_instance,
    this.payload,
  });

  UpdateNewInlineCallbackQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    sender_user_id = map['sender_user_id'];
    inline_message_id = map['inline_message_id'];
    chat_instance = map['chat_instance'];
    payload = TdApiMap.fromMap(map['payload']) as CallbackQueryPayload;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'sender_user_id': sender_user_id?.toMap(skipNulls: skipNulls),
      'inline_message_id': inline_message_id?.toMap(skipNulls: skipNulls),
      'chat_instance': chat_instance?.toMap(skipNulls: skipNulls),
      'payload': payload?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewShippingQuery extends Update {
  String get tdType => 'updateNewShippingQuery';

  string? extra;
  int? client_id;
  int64? id;
  int53? sender_user_id;
  string? invoice_payload;
  Address? shipping_address;

  UpdateNewShippingQuery({
    this.extra,
    this.client_id,
    this.id,
    this.sender_user_id,
    this.invoice_payload,
    this.shipping_address,
  });

  UpdateNewShippingQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    sender_user_id = map['sender_user_id'];
    invoice_payload = map['invoice_payload'];
    shipping_address = TdApiMap.fromMap(map['shipping_address']) as Address;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'sender_user_id': sender_user_id?.toMap(skipNulls: skipNulls),
      'invoice_payload': invoice_payload?.toMap(skipNulls: skipNulls),
      'shipping_address': shipping_address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewPreCheckoutQuery extends Update {
  String get tdType => 'updateNewPreCheckoutQuery';

  string? extra;
  int? client_id;
  int64? id;
  int53? sender_user_id;
  string? currency;
  int53? total_amount;
  bytes? invoice_payload;
  string? shipping_option_id;
  OrderInfo? order_info;

  UpdateNewPreCheckoutQuery({
    this.extra,
    this.client_id,
    this.id,
    this.sender_user_id,
    this.currency,
    this.total_amount,
    this.invoice_payload,
    this.shipping_option_id,
    this.order_info,
  });

  UpdateNewPreCheckoutQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    sender_user_id = map['sender_user_id'];
    currency = map['currency'];
    total_amount = map['total_amount'];
    invoice_payload = map['invoice_payload'];
    shipping_option_id = map['shipping_option_id'];
    order_info = TdApiMap.fromMap(map['order_info']) as OrderInfo;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'sender_user_id': sender_user_id?.toMap(skipNulls: skipNulls),
      'currency': currency?.toMap(skipNulls: skipNulls),
      'total_amount': total_amount?.toMap(skipNulls: skipNulls),
      'invoice_payload': invoice_payload?.toMap(skipNulls: skipNulls),
      'shipping_option_id': shipping_option_id?.toMap(skipNulls: skipNulls),
      'order_info': order_info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewCustomEvent extends Update {
  String get tdType => 'updateNewCustomEvent';

  string? extra;
  int? client_id;
  string? event;

  UpdateNewCustomEvent({
    this.extra,
    this.client_id,
    this.event,
  });

  UpdateNewCustomEvent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    event = map['event'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'event': event?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewCustomQuery extends Update {
  String get tdType => 'updateNewCustomQuery';

  string? extra;
  int? client_id;
  int64? id;
  string? data;
  int32? timeout;

  UpdateNewCustomQuery({
    this.extra,
    this.client_id,
    this.id,
    this.data,
    this.timeout,
  });

  UpdateNewCustomQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    data = map['data'];
    timeout = map['timeout'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
      'timeout': timeout?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdatePoll extends Update {
  String get tdType => 'updatePoll';

  string? extra;
  int? client_id;
  Poll? poll;

  UpdatePoll({
    this.extra,
    this.client_id,
    this.poll,
  });

  UpdatePoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    poll = TdApiMap.fromMap(map['poll']) as Poll;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'poll': poll?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdatePollAnswer extends Update {
  String get tdType => 'updatePollAnswer';

  string? extra;
  int? client_id;
  int64? poll_id;
  int53? user_id;
  vector<int32>? option_ids;

  UpdatePollAnswer({
    this.extra,
    this.client_id,
    this.poll_id,
    this.user_id,
    this.option_ids,
  });

  UpdatePollAnswer.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    poll_id = map['poll_id'];
    user_id = map['user_id'];
    if (map['option_ids']) {
      option_ids = [];
      for (var someValue in map['option_ids']) {
        option_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'poll_id': poll_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'option_ids': option_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateChatMember extends Update {
  String get tdType => 'updateChatMember';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? actor_user_id;
  int32? date;
  ChatInviteLink? invite_link;
  ChatMember? old_chat_member;
  ChatMember? new_chat_member;

  UpdateChatMember({
    this.extra,
    this.client_id,
    this.chat_id,
    this.actor_user_id,
    this.date,
    this.invite_link,
    this.old_chat_member,
    this.new_chat_member,
  });

  UpdateChatMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    actor_user_id = map['actor_user_id'];
    date = map['date'];
    invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    old_chat_member = TdApiMap.fromMap(map['old_chat_member']) as ChatMember;
    new_chat_member = TdApiMap.fromMap(map['new_chat_member']) as ChatMember;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'actor_user_id': actor_user_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'old_chat_member': old_chat_member?.toMap(skipNulls: skipNulls),
      'new_chat_member': new_chat_member?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class UpdateNewChatJoinRequest extends Update {
  String get tdType => 'updateNewChatJoinRequest';

  string? extra;
  int? client_id;
  int53? chat_id;
  ChatJoinRequest? request;
  ChatInviteLink? invite_link;

  UpdateNewChatJoinRequest({
    this.extra,
    this.client_id,
    this.chat_id,
    this.request,
    this.invite_link,
  });

  UpdateNewChatJoinRequest.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    request = TdApiMap.fromMap(map['request']) as ChatJoinRequest;
    invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'request': request?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

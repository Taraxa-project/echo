import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/authorization_state.dart';
import 'package:td_json_client/api/object/message.dart';
import 'package:td_json_client/api/object/message_content.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/message_interaction_info.dart';
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

/// Contains notifications about data changes
abstract class Update extends TdObject {}


/// The user authorization state has changed 
class UpdateAuthorizationState extends Update {
  String get tdType => 'updateAuthorizationState';

  String? extra;
  int? client_id;

  /// New authorization state
  AuthorizationState? authorization_state;

  UpdateAuthorizationState({
    this.extra,
    this.client_id,
    this.authorization_state,
  });

  UpdateAuthorizationState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['authorization_state'] != null) {
      authorization_state = TdApiMap.fromMap(map['authorization_state']) as AuthorizationState;
    }
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

/// A new message was received; can also be an outgoing message 
class UpdateNewMessage extends Update {
  String get tdType => 'updateNewMessage';

  String? extra;
  int? client_id;

  /// The new message
  Message? message;

  UpdateNewMessage({
    this.extra,
    this.client_id,
    this.message,
  });

  UpdateNewMessage.fromMap(Map<String, dynamic> map) {
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

/// A request to send a message has reached the Telegram server. This doesn't mean that the message will be sent successfully or even that the send message request will be processed. This update will be sent only if the option "use_quick_ack" is set to true. This update may be sent multiple times for the same message
class UpdateMessageSendAcknowledged extends Update {
  String get tdType => 'updateMessageSendAcknowledged';

  String? extra;
  int? client_id;

  /// The chat identifier of the sent message 
  int53? chat_id;

  /// A temporary message identifier
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

/// A message has been successfully sent 
class UpdateMessageSendSucceeded extends Update {
  String get tdType => 'updateMessageSendSucceeded';

  String? extra;
  int? client_id;

  /// The sent message. Usually only the message identifier, date, and content are changed, but almost all other fields can also change 
  Message? message;

  /// The previous temporary message identifier
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
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as Message;
    }
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

/// A message failed to send. Be aware that some messages being sent can be irrecoverably deleted, in which case updateDeleteMessages will be received instead of this update
class UpdateMessageSendFailed extends Update {
  String get tdType => 'updateMessageSendFailed';

  String? extra;
  int? client_id;

  /// The failed to send message 
  Message? message;

  /// The previous temporary message identifier 
  int53? old_message_id;

  /// An error code 
  int32? error_code;

  /// Error message
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
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as Message;
    }
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

/// The message content has changed 
class UpdateMessageContent extends Update {
  String get tdType => 'updateMessageContent';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Message identifier 
  int53? message_id;

  /// New message content
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
    if (map['new_content'] != null) {
      new_content = TdApiMap.fromMap(map['new_content']) as MessageContent;
    }
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

/// A message was edited. Changes in the message content will come in a separate updateMessageContent 
class UpdateMessageEdited extends Update {
  String get tdType => 'updateMessageEdited';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Message identifier 
  int53? message_id;

  /// Point in time (Unix timestamp) when the message was edited 
  int32? edit_date;

  /// New message reply markup; may be null
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
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

/// The message pinned state was changed 
class UpdateMessageIsPinned extends Update {
  String get tdType => 'updateMessageIsPinned';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The message identifier 
  int53? message_id;

  /// True, if the message is pinned
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

/// The information about interactions with a message has changed 
class UpdateMessageInteractionInfo extends Update {
  String get tdType => 'updateMessageInteractionInfo';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Message identifier 
  int53? message_id;

  /// New information about interactions with the message; may be null
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
    if (map['interaction_info'] != null) {
      interaction_info = TdApiMap.fromMap(map['interaction_info']) as MessageInteractionInfo;
    }
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

/// The message content was opened. Updates voice note messages to "listened", video note messages to "viewed" and starts the TTL timer for self-destructing messages 
class UpdateMessageContentOpened extends Update {
  String get tdType => 'updateMessageContentOpened';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Message identifier
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

/// A message with an unread mention was read 
class UpdateMessageMentionRead extends Update {
  String get tdType => 'updateMessageMentionRead';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Message identifier 
  int53? message_id;

  /// The new number of unread mention messages left in the chat
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

/// A message with a live location was viewed. When the update is received, the application is supposed to update the live location
class UpdateMessageLiveLocationViewed extends Update {
  String get tdType => 'updateMessageLiveLocationViewed';

  String? extra;
  int? client_id;

  /// Identifier of the chat with the live location message 
  int53? chat_id;

  /// Identifier of the message with live location
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

/// A new chat has been loaded/created. This update is guaranteed to come before the chat identifier is returned to the application. The chat field changes will be reported through separate updates 
class UpdateNewChat extends Update {
  String get tdType => 'updateNewChat';

  String? extra;
  int? client_id;

  /// The chat
  Chat? chat;

  UpdateNewChat({
    this.extra,
    this.client_id,
    this.chat,
  });

  UpdateNewChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat'] != null) {
      chat = TdApiMap.fromMap(map['chat']) as Chat;
    }
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

/// The title of a chat was changed 
class UpdateChatTitle extends Update {
  String get tdType => 'updateChatTitle';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new chat title
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

/// A chat photo was changed 
class UpdateChatPhoto extends Update {
  String get tdType => 'updateChatPhoto';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new chat photo; may be null
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
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhotoInfo;
    }
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

/// Chat permissions was changed 
class UpdateChatPermissions extends Update {
  String get tdType => 'updateChatPermissions';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new chat permissions
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
    if (map['permissions'] != null) {
      permissions = TdApiMap.fromMap(map['permissions']) as ChatPermissions;
    }
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

/// The last message of a chat was changed. If last_message is null, then the last message in the chat became unknown. Some new unknown messages might be added to the chat in this case 
class UpdateChatLastMessage extends Update {
  String get tdType => 'updateChatLastMessage';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new last message in the chat; may be null 
  Message? last_message;

  /// The new chat positions in the chat lists
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
    if (map['last_message'] != null) {
      last_message = TdApiMap.fromMap(map['last_message']) as Message;
    }
    if (map['positions'] != null) {
      positions = [];
      for (var someValue in map['positions']) {
        if (someValue != null) {
          positions?.add(TdApiMap.fromMap(someValue) as ChatPosition);
        }
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

/// The position of a chat in a chat list has changed. Instead of this update updateChatLastMessage or updateChatDraftMessage might be sent 
class UpdateChatPosition extends Update {
  String get tdType => 'updateChatPosition';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New chat position. If new order is 0, then the chat needs to be removed from the list
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
    if (map['position'] != null) {
      position = TdApiMap.fromMap(map['position']) as ChatPosition;
    }
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

/// Incoming messages were read or the number of unread messages has been changed 
class UpdateChatReadInbox extends Update {
  String get tdType => 'updateChatReadInbox';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Identifier of the last read incoming message 
  int53? last_read_inbox_message_id;

  /// The number of unread messages left in the chat
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

/// Outgoing messages were read 
class UpdateChatReadOutbox extends Update {
  String get tdType => 'updateChatReadOutbox';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Identifier of last read outgoing message
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

/// The chat action bar was changed 
class UpdateChatActionBar extends Update {
  String get tdType => 'updateChatActionBar';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new value of the action bar; may be null
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
    if (map['action_bar'] != null) {
      action_bar = TdApiMap.fromMap(map['action_bar']) as ChatActionBar;
    }
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

/// A chat draft has changed. Be aware that the update may come in the currently opened chat but with old content of the draft. If the user has changed the content of the draft, this update mustn't be applied 
class UpdateChatDraftMessage extends Update {
  String get tdType => 'updateChatDraftMessage';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new draft message; may be null 
  DraftMessage? draft_message;

  /// The new chat positions in the chat lists
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
    if (map['draft_message'] != null) {
      draft_message = TdApiMap.fromMap(map['draft_message']) as DraftMessage;
    }
    if (map['positions'] != null) {
      positions = [];
      for (var someValue in map['positions']) {
        if (someValue != null) {
          positions?.add(TdApiMap.fromMap(someValue) as ChatPosition);
        }
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

/// The message sender that is selected to send messages in a chat has changed 
class UpdateChatMessageSender extends Update {
  String get tdType => 'updateChatMessageSender';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New value of message_sender_id; may be null if the user can't change message sender
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
    if (map['message_sender_id'] != null) {
      message_sender_id = TdApiMap.fromMap(map['message_sender_id']) as MessageSender;
    }
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

/// The message Time To Live setting for a chat was changed 
class UpdateChatMessageTtl extends Update {
  String get tdType => 'updateChatMessageTtl';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New value of message_ttl
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

/// Notification settings for a chat were changed 
class UpdateChatNotificationSettings extends Update {
  String get tdType => 'updateChatNotificationSettings';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new notification settings
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
    if (map['notification_settings'] != null) {
      notification_settings = TdApiMap.fromMap(map['notification_settings']) as ChatNotificationSettings;
    }
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

/// The chat pending join requests were changed 
class UpdateChatPendingJoinRequests extends Update {
  String get tdType => 'updateChatPendingJoinRequests';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new data about pending join requests; may be null
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
    if (map['pending_join_requests'] != null) {
      pending_join_requests = TdApiMap.fromMap(map['pending_join_requests']) as ChatJoinRequestsInfo;
    }
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

/// The default chat reply markup was changed. Can occur because new messages with reply markup were received or because an old reply markup was hidden by the user
class UpdateChatReplyMarkup extends Update {
  String get tdType => 'updateChatReplyMarkup';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Identifier of the message from which reply markup needs to be used; 0 if there is no default custom reply markup in the chat
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

/// The chat theme was changed 
class UpdateChatTheme extends Update {
  String get tdType => 'updateChatTheme';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new name of the chat theme; may be empty if theme was reset to default
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

/// The chat unread_mention_count has changed 
class UpdateChatUnreadMentionCount extends Update {
  String get tdType => 'updateChatUnreadMentionCount';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The number of unread mention messages left in the chat
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

/// A chat video chat state has changed 
class UpdateChatVideoChat extends Update {
  String get tdType => 'updateChatVideoChat';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New value of video_chat
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
    if (map['video_chat'] != null) {
      video_chat = TdApiMap.fromMap(map['video_chat']) as VideoChat;
    }
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

/// The value of the default disable_notification parameter, used when a message is sent to the chat, was changed 
class UpdateChatDefaultDisableNotification extends Update {
  String get tdType => 'updateChatDefaultDisableNotification';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// The new default_disable_notification value
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

/// A chat content was allowed or restricted for saving 
class UpdateChatHasProtectedContent extends Update {
  String get tdType => 'updateChatHasProtectedContent';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New value of has_protected_content
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

/// A chat's has_scheduled_messages field has changed 
class UpdateChatHasScheduledMessages extends Update {
  String get tdType => 'updateChatHasScheduledMessages';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New value of has_scheduled_messages
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

/// A chat was blocked or unblocked 
class UpdateChatIsBlocked extends Update {
  String get tdType => 'updateChatIsBlocked';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New value of is_blocked
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

/// A chat was marked as unread or was read 
class UpdateChatIsMarkedAsUnread extends Update {
  String get tdType => 'updateChatIsMarkedAsUnread';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New value of is_marked_as_unread
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

/// The list of chat filters or a chat filter has changed 
class UpdateChatFilters extends Update {
  String get tdType => 'updateChatFilters';

  String? extra;
  int? client_id;

  /// The new list of chat filters
  vector<ChatFilterInfo>? chat_filters;

  UpdateChatFilters({
    this.extra,
    this.client_id,
    this.chat_filters,
  });

  UpdateChatFilters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_filters'] != null) {
      chat_filters = [];
      for (var someValue in map['chat_filters']) {
        if (someValue != null) {
          chat_filters?.add(TdApiMap.fromMap(someValue) as ChatFilterInfo);
        }
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

/// The number of online group members has changed. This update with non-zero count is sent only for currently opened chats. There is no guarantee that it will be sent just after the count has changed 
class UpdateChatOnlineMemberCount extends Update {
  String get tdType => 'updateChatOnlineMemberCount';

  String? extra;
  int? client_id;

  /// Identifier of the chat 
  int53? chat_id;

  /// New number of online members in the chat, or 0 if unknown
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

/// Notification settings for some type of chats were updated 
class UpdateScopeNotificationSettings extends Update {
  String get tdType => 'updateScopeNotificationSettings';

  String? extra;
  int? client_id;

  /// Types of chats for which notification settings were updated 
  NotificationSettingsScope? scope;

  /// The new notification settings
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
    if (map['scope'] != null) {
      scope = TdApiMap.fromMap(map['scope']) as NotificationSettingsScope;
    }
    if (map['notification_settings'] != null) {
      notification_settings = TdApiMap.fromMap(map['notification_settings']) as ScopeNotificationSettings;
    }
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

/// A notification was changed 
class UpdateNotification extends Update {
  String get tdType => 'updateNotification';

  String? extra;
  int? client_id;

  /// Unique notification group identifier 
  int32? notification_group_id;

  /// Changed notification
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
    if (map['notification'] != null) {
      notification = TdApiMap.fromMap(map['notification']) as Notification;
    }
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

/// A list of active notifications in a notification group has changed
class UpdateNotificationGroup extends Update {
  String get tdType => 'updateNotificationGroup';

  String? extra;
  int? client_id;

  /// Unique notification group identifier
  int32? notification_group_id;

  /// New type of the notification group
  NotificationGroupType? type;

  /// Identifier of a chat to which all notifications in the group belong
  int53? chat_id;

  /// Chat identifier, which notification settings must be applied to the added notifications
  int53? notification_settings_chat_id;

  /// True, if the notifications must be shown without sound
  Bool? is_silent;

  /// Total number of unread notifications in the group, can be bigger than number of active notifications
  int32? total_count;

  /// List of added group notifications, sorted by notification ID 
  vector<Notification>? added_notifications;

  /// Identifiers of removed group notifications, sorted by notification ID
  vector<int32>? removed_notification_ids;

  UpdateNotificationGroup({
    this.extra,
    this.client_id,
    this.notification_group_id,
    this.type,
    this.chat_id,
    this.notification_settings_chat_id,
    this.is_silent,
    this.total_count,
    this.added_notifications,
    this.removed_notification_ids,
  });

  UpdateNotificationGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    notification_group_id = map['notification_group_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as NotificationGroupType;
    }
    chat_id = map['chat_id'];
    notification_settings_chat_id = map['notification_settings_chat_id'];
    is_silent = map['is_silent'];
    total_count = map['total_count'];
    if (map['added_notifications'] != null) {
      added_notifications = [];
      for (var someValue in map['added_notifications']) {
        if (someValue != null) {
          added_notifications?.add(TdApiMap.fromMap(someValue) as Notification);
        }
      }
    }
    if (map['removed_notification_ids'] != null) {
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
      'is_silent': is_silent?.toMap(skipNulls: skipNulls),
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

/// Contains active notifications that was shown on previous application launches. This update is sent only if the message database is used. In that case it comes once before any updateNotification and updateNotificationGroup update 
class UpdateActiveNotifications extends Update {
  String get tdType => 'updateActiveNotifications';

  String? extra;
  int? client_id;

  /// Lists of active notification groups
  vector<NotificationGroup>? groups;

  UpdateActiveNotifications({
    this.extra,
    this.client_id,
    this.groups,
  });

  UpdateActiveNotifications.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['groups'] != null) {
      groups = [];
      for (var someValue in map['groups']) {
        if (someValue != null) {
          groups?.add(TdApiMap.fromMap(someValue) as NotificationGroup);
        }
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

/// Describes whether there are some pending notification updates. Can be used to prevent application from killing, while there are some pending notifications
class UpdateHavePendingNotifications extends Update {
  String get tdType => 'updateHavePendingNotifications';

  String? extra;
  int? client_id;

  /// True, if there are some delayed notification updates, which will be sent soon
  Bool? have_delayed_notifications;

  /// True, if there can be some yet unreceived notifications, which are being fetched from the server
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

/// Some messages were deleted 
class UpdateDeleteMessages extends Update {
  String get tdType => 'updateDeleteMessages';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Identifiers of the deleted messages
  vector<int53>? message_ids;

  /// True, if the messages are permanently deleted by a user (as opposed to just becoming inaccessible)
  Bool? is_permanent;

  /// True, if the messages are deleted only from the cache and can possibly be retrieved again in the future
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
    if (map['message_ids'] != null) {
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

/// A message sender activity in the chat has changed 
class UpdateChatAction extends Update {
  String get tdType => 'updateChatAction';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// If not 0, a message thread identifier in which the action was performed 
  int53? message_thread_id;

  /// Identifier of a message sender performing the action 
  MessageSender? sender_id;

  /// The action
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
    if (map['sender_id'] != null) {
      sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    }
    if (map['action'] != null) {
      action = TdApiMap.fromMap(map['action']) as ChatAction;
    }
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

/// The user went online or offline 
class UpdateUserStatus extends Update {
  String get tdType => 'updateUserStatus';

  String? extra;
  int? client_id;

  /// User identifier 
  int53? user_id;

  /// New status of the user
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
    if (map['status'] != null) {
      status = TdApiMap.fromMap(map['status']) as UserStatus;
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

/// Some data of a user has changed. This update is guaranteed to come before the user identifier is returned to the application 
class UpdateUser extends Update {
  String get tdType => 'updateUser';

  String? extra;
  int? client_id;

  /// New data about the user
  User? user;

  UpdateUser({
    this.extra,
    this.client_id,
    this.user,
  });

  UpdateUser.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['user'] != null) {
      user = TdApiMap.fromMap(map['user']) as User;
    }
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

/// Some data of a basic group has changed. This update is guaranteed to come before the basic group identifier is returned to the application 
class UpdateBasicGroup extends Update {
  String get tdType => 'updateBasicGroup';

  String? extra;
  int? client_id;

  /// New data about the group
  BasicGroup? basic_group;

  UpdateBasicGroup({
    this.extra,
    this.client_id,
    this.basic_group,
  });

  UpdateBasicGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['basic_group'] != null) {
      basic_group = TdApiMap.fromMap(map['basic_group']) as BasicGroup;
    }
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

/// Some data of a supergroup or a channel has changed. This update is guaranteed to come before the supergroup identifier is returned to the application 
class UpdateSupergroup extends Update {
  String get tdType => 'updateSupergroup';

  String? extra;
  int? client_id;

  /// New data about the supergroup
  Supergroup? supergroup;

  UpdateSupergroup({
    this.extra,
    this.client_id,
    this.supergroup,
  });

  UpdateSupergroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['supergroup'] != null) {
      supergroup = TdApiMap.fromMap(map['supergroup']) as Supergroup;
    }
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

/// Some data of a secret chat has changed. This update is guaranteed to come before the secret chat identifier is returned to the application 
class UpdateSecretChat extends Update {
  String get tdType => 'updateSecretChat';

  String? extra;
  int? client_id;

  /// New data about the secret chat
  SecretChat? secret_chat;

  UpdateSecretChat({
    this.extra,
    this.client_id,
    this.secret_chat,
  });

  UpdateSecretChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['secret_chat'] != null) {
      secret_chat = TdApiMap.fromMap(map['secret_chat']) as SecretChat;
    }
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

/// Some data in userFullInfo has been changed 
class UpdateUserFullInfo extends Update {
  String get tdType => 'updateUserFullInfo';

  String? extra;
  int? client_id;

  /// User identifier 
  int53? user_id;

  /// New full information about the user
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
    if (map['user_full_info'] != null) {
      user_full_info = TdApiMap.fromMap(map['user_full_info']) as UserFullInfo;
    }
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

/// Some data in basicGroupFullInfo has been changed 
class UpdateBasicGroupFullInfo extends Update {
  String get tdType => 'updateBasicGroupFullInfo';

  String? extra;
  int? client_id;

  /// Identifier of a basic group 
  int53? basic_group_id;

  /// New full information about the group
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
    if (map['basic_group_full_info'] != null) {
      basic_group_full_info = TdApiMap.fromMap(map['basic_group_full_info']) as BasicGroupFullInfo;
    }
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

/// Some data in supergroupFullInfo has been changed 
class UpdateSupergroupFullInfo extends Update {
  String get tdType => 'updateSupergroupFullInfo';

  String? extra;
  int? client_id;

  /// Identifier of the supergroup or channel 
  int53? supergroup_id;

  /// New full information about the supergroup
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
    if (map['supergroup_full_info'] != null) {
      supergroup_full_info = TdApiMap.fromMap(map['supergroup_full_info']) as SupergroupFullInfo;
    }
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

/// A service notification from the server was received. Upon receiving this the application must show a popup with the content of the notification
class UpdateServiceNotification extends Update {
  String get tdType => 'updateServiceNotification';

  String? extra;
  int? client_id;

  /// Notification type. If type begins with "AUTH_KEY_DROP_", then two buttons "Cancel" and "Log out" must be shown under notification; if user presses the second, all local data must be destroyed using Destroy method
  string? type;

  /// Notification content
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
    if (map['content'] != null) {
      content = TdApiMap.fromMap(map['content']) as MessageContent;
    }
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

/// Information about a file was updated 
class UpdateFile extends Update {
  String get tdType => 'updateFile';

  String? extra;
  int? client_id;

  /// New data about the file
  File? file;

  UpdateFile({
    this.extra,
    this.client_id,
    this.file,
  });

  UpdateFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['file'] != null) {
      file = TdApiMap.fromMap(map['file']) as File;
    }
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

/// The file generation process needs to be started by the application
class UpdateFileGenerationStart extends Update {
  String get tdType => 'updateFileGenerationStart';

  String? extra;
  int? client_id;

  /// Unique identifier for the generation process
  int64? generation_id;

  /// The path to a file from which a new file is generated; may be empty
  string? original_path;

  /// The path to a file that must be created and where the new file is generated
  string? destination_path;

  /// String specifying the conversion applied to the original file. If conversion is "#url#" than original_path contains an HTTP/HTTPS URL of a file, which must be downloaded by the application
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

/// File generation is no longer needed 
class UpdateFileGenerationStop extends Update {
  String get tdType => 'updateFileGenerationStop';

  String? extra;
  int? client_id;

  /// Unique identifier for the generation process
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

/// New call was created or information about a call was updated 
class UpdateCall extends Update {
  String get tdType => 'updateCall';

  String? extra;
  int? client_id;

  /// New data about a call
  Call? call;

  UpdateCall({
    this.extra,
    this.client_id,
    this.call,
  });

  UpdateCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['call'] != null) {
      call = TdApiMap.fromMap(map['call']) as Call;
    }
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

/// Information about a group call was updated 
class UpdateGroupCall extends Update {
  String get tdType => 'updateGroupCall';

  String? extra;
  int? client_id;

  /// New data about a group call
  GroupCall? group_call;

  UpdateGroupCall({
    this.extra,
    this.client_id,
    this.group_call,
  });

  UpdateGroupCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['group_call'] != null) {
      group_call = TdApiMap.fromMap(map['group_call']) as GroupCall;
    }
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

/// Information about a group call participant was changed. The updates are sent only after the group call is received through getGroupCall and only if the call is joined or being joined
class UpdateGroupCallParticipant extends Update {
  String get tdType => 'updateGroupCallParticipant';

  String? extra;
  int? client_id;

  /// Identifier of group call 
  int32? group_call_id;

  /// New data about a participant
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
    if (map['participant'] != null) {
      participant = TdApiMap.fromMap(map['participant']) as GroupCallParticipant;
    }
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

/// New call signaling data arrived 
class UpdateNewCallSignalingData extends Update {
  String get tdType => 'updateNewCallSignalingData';

  String? extra;
  int? client_id;

  /// The call identifier 
  int32? call_id;

  /// The data
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

/// Some privacy setting rules have been changed 
class UpdateUserPrivacySettingRules extends Update {
  String get tdType => 'updateUserPrivacySettingRules';

  String? extra;
  int? client_id;

  /// The privacy setting 
  UserPrivacySetting? setting;

  /// New privacy rules
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
    if (map['setting'] != null) {
      setting = TdApiMap.fromMap(map['setting']) as UserPrivacySetting;
    }
    if (map['rules'] != null) {
      rules = TdApiMap.fromMap(map['rules']) as UserPrivacySettingRules;
    }
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

/// Number of unread messages in a chat list has changed. This update is sent only if the message database is used 
class UpdateUnreadMessageCount extends Update {
  String get tdType => 'updateUnreadMessageCount';

  String? extra;
  int? client_id;

  /// The chat list with changed number of unread messages
  ChatList? chat_list;

  /// Total number of unread messages 
  int32? unread_count;

  /// Total number of unread messages in unmuted chats
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
    if (map['chat_list'] != null) {
      chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
    }
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

/// Number of unread chats, i.e. with unread messages or marked as unread, has changed. This update is sent only if the message database is used
class UpdateUnreadChatCount extends Update {
  String get tdType => 'updateUnreadChatCount';

  String? extra;
  int? client_id;

  /// The chat list with changed number of unread messages
  ChatList? chat_list;

  /// Approximate total number of chats in the chat list
  int32? total_count;

  /// Total number of unread chats 
  int32? unread_count;

  /// Total number of unread unmuted chats
  int32? unread_unmuted_count;

  /// Total number of chats marked as unread 
  int32? marked_as_unread_count;

  /// Total number of unmuted chats marked as unread
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
    if (map['chat_list'] != null) {
      chat_list = TdApiMap.fromMap(map['chat_list']) as ChatList;
    }
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

/// An option changed its value 
class UpdateOption extends Update {
  String get tdType => 'updateOption';

  String? extra;
  int? client_id;

  /// The option name 
  string? name;

  /// The new option value
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
    if (map['value'] != null) {
      value = TdApiMap.fromMap(map['value']) as OptionValue;
    }
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

/// A sticker set has changed 
class UpdateStickerSet extends Update {
  String get tdType => 'updateStickerSet';

  String? extra;
  int? client_id;

  /// The sticker set
  StickerSet? sticker_set;

  UpdateStickerSet({
    this.extra,
    this.client_id,
    this.sticker_set,
  });

  UpdateStickerSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_set'] != null) {
      sticker_set = TdApiMap.fromMap(map['sticker_set']) as StickerSet;
    }
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

/// The list of installed sticker sets was updated 
class UpdateInstalledStickerSets extends Update {
  String get tdType => 'updateInstalledStickerSets';

  String? extra;
  int? client_id;

  /// True, if the list of installed mask sticker sets was updated 
  Bool? is_masks;

  /// The new list of installed ordinary sticker sets
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
    if (map['sticker_set_ids'] != null) {
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

/// The list of trending sticker sets was updated or some of them were viewed 
class UpdateTrendingStickerSets extends Update {
  String get tdType => 'updateTrendingStickerSets';

  String? extra;
  int? client_id;

  /// The prefix of the list of trending sticker sets with the newest trending sticker sets
  StickerSets? sticker_sets;

  UpdateTrendingStickerSets({
    this.extra,
    this.client_id,
    this.sticker_sets,
  });

  UpdateTrendingStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_sets'] != null) {
      sticker_sets = TdApiMap.fromMap(map['sticker_sets']) as StickerSets;
    }
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

/// The list of recently used stickers was updated 
class UpdateRecentStickers extends Update {
  String get tdType => 'updateRecentStickers';

  String? extra;
  int? client_id;

  /// True, if the list of stickers attached to photo or video files was updated, otherwise the list of sent stickers is updated 
  Bool? is_attached;

  /// The new list of file identifiers of recently used stickers
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
    if (map['sticker_ids'] != null) {
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

/// The list of favorite stickers was updated 
class UpdateFavoriteStickers extends Update {
  String get tdType => 'updateFavoriteStickers';

  String? extra;
  int? client_id;

  /// The new list of file identifiers of favorite stickers
  vector<int32>? sticker_ids;

  UpdateFavoriteStickers({
    this.extra,
    this.client_id,
    this.sticker_ids,
  });

  UpdateFavoriteStickers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_ids'] != null) {
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

/// The list of saved animations was updated 
class UpdateSavedAnimations extends Update {
  String get tdType => 'updateSavedAnimations';

  String? extra;
  int? client_id;

  /// The new list of file identifiers of saved animations
  vector<int32>? animation_ids;

  UpdateSavedAnimations({
    this.extra,
    this.client_id,
    this.animation_ids,
  });

  UpdateSavedAnimations.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['animation_ids'] != null) {
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

/// The selected background has changed 
class UpdateSelectedBackground extends Update {
  String get tdType => 'updateSelectedBackground';

  String? extra;
  int? client_id;

  /// True, if background for dark theme has changed 
  Bool? for_dark_theme;

  /// The new selected background; may be null
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
    if (map['background'] != null) {
      background = TdApiMap.fromMap(map['background']) as Background;
    }
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

/// The list of available chat themes has changed 
class UpdateChatThemes extends Update {
  String get tdType => 'updateChatThemes';

  String? extra;
  int? client_id;

  /// The new list of chat themes
  vector<ChatTheme>? chat_themes;

  UpdateChatThemes({
    this.extra,
    this.client_id,
    this.chat_themes,
  });

  UpdateChatThemes.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_themes'] != null) {
      chat_themes = [];
      for (var someValue in map['chat_themes']) {
        if (someValue != null) {
          chat_themes?.add(TdApiMap.fromMap(someValue) as ChatTheme);
        }
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

/// Some language pack strings have been updated 
class UpdateLanguagePackStrings extends Update {
  String get tdType => 'updateLanguagePackStrings';

  String? extra;
  int? client_id;

  /// Localization target to which the language pack belongs 
  string? localization_target;

  /// Identifier of the updated language pack 
  string? language_pack_id;

  /// List of changed language pack strings
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
    if (map['strings'] != null) {
      strings = [];
      for (var someValue in map['strings']) {
        if (someValue != null) {
          strings?.add(TdApiMap.fromMap(someValue) as LanguagePackString);
        }
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

/// The connection state has changed. This update must be used only to show a human-readable description of the connection state 
class UpdateConnectionState extends Update {
  String get tdType => 'updateConnectionState';

  String? extra;
  int? client_id;

  /// The new connection state
  ConnectionState? state;

  UpdateConnectionState({
    this.extra,
    this.client_id,
    this.state,
  });

  UpdateConnectionState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['state'] != null) {
      state = TdApiMap.fromMap(map['state']) as ConnectionState;
    }
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

/// New terms of service must be accepted by the user. If the terms of service are declined, then the deleteAccount method must be called with the reason "Decline ToS update" 
class UpdateTermsOfService extends Update {
  String get tdType => 'updateTermsOfService';

  String? extra;
  int? client_id;

  /// Identifier of the terms of service 
  string? terms_of_service_id;

  /// The new terms of service
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
    if (map['terms_of_service'] != null) {
      terms_of_service = TdApiMap.fromMap(map['terms_of_service']) as TermsOfService;
    }
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

/// The list of users nearby has changed. The update is guaranteed to be sent only 60 seconds after a successful searchChatsNearby request 
class UpdateUsersNearby extends Update {
  String get tdType => 'updateUsersNearby';

  String? extra;
  int? client_id;

  /// The new list of users nearby
  vector<ChatNearby>? users_nearby;

  UpdateUsersNearby({
    this.extra,
    this.client_id,
    this.users_nearby,
  });

  UpdateUsersNearby.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['users_nearby'] != null) {
      users_nearby = [];
      for (var someValue in map['users_nearby']) {
        if (someValue != null) {
          users_nearby?.add(TdApiMap.fromMap(someValue) as ChatNearby);
        }
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

/// The list of supported dice emojis has changed 
class UpdateDiceEmojis extends Update {
  String get tdType => 'updateDiceEmojis';

  String? extra;
  int? client_id;

  /// The new list of supported dice emojis
  vector<string>? emojis;

  UpdateDiceEmojis({
    this.extra,
    this.client_id,
    this.emojis,
  });

  UpdateDiceEmojis.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['emojis'] != null) {
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

/// Some animated emoji message was clicked and a big animated sticker must be played if the message is visible on the screen. chatActionWatchingAnimations with the text of the message needs to be sent if the sticker is played
class UpdateAnimatedEmojiMessageClicked extends Update {
  String get tdType => 'updateAnimatedEmojiMessageClicked';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Message identifier 
  int53? message_id;

  /// The animated sticker to be played
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
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    }
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

/// The parameters of animation search through GetOption("animation_search_bot_username") bot has changed 
class UpdateAnimationSearchParameters extends Update {
  String get tdType => 'updateAnimationSearchParameters';

  String? extra;
  int? client_id;

  /// Name of the animation search provider 
  string? provider;

  /// The new list of emojis suggested for searching
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
    if (map['emojis'] != null) {
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

/// The list of suggested to the user actions has changed 
class UpdateSuggestedActions extends Update {
  String get tdType => 'updateSuggestedActions';

  String? extra;
  int? client_id;

  /// Added suggested actions 
  vector<SuggestedAction>? added_actions;

  /// Removed suggested actions
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
    if (map['added_actions'] != null) {
      added_actions = [];
      for (var someValue in map['added_actions']) {
        if (someValue != null) {
          added_actions?.add(TdApiMap.fromMap(someValue) as SuggestedAction);
        }
      }
    }
    if (map['removed_actions'] != null) {
      removed_actions = [];
      for (var someValue in map['removed_actions']) {
        if (someValue != null) {
          removed_actions?.add(TdApiMap.fromMap(someValue) as SuggestedAction);
        }
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

/// A new incoming inline query; for bots only 
class UpdateNewInlineQuery extends Update {
  String get tdType => 'updateNewInlineQuery';

  String? extra;
  int? client_id;

  /// Unique query identifier 
  int64? id;

  /// Identifier of the user who sent the query 
  int53? sender_user_id;

  /// User location; may be null
  Location? user_location;

  /// The type of the chat, from which the query originated; may be null if unknown 
  ChatType? chat_type;

  /// Text of the query 
  string? query;

  /// Offset of the first entry to return
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
    if (map['user_location'] != null) {
      user_location = TdApiMap.fromMap(map['user_location']) as Location;
    }
    if (map['chat_type'] != null) {
      chat_type = TdApiMap.fromMap(map['chat_type']) as ChatType;
    }
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

/// The user has chosen a result of an inline query; for bots only 
class UpdateNewChosenInlineResult extends Update {
  String get tdType => 'updateNewChosenInlineResult';

  String? extra;
  int? client_id;

  /// Identifier of the user who sent the query 
  int53? sender_user_id;

  /// User location; may be null
  Location? user_location;

  /// Text of the query 
  string? query;

  /// Identifier of the chosen result 
  string? result_id;

  /// Identifier of the sent inline message, if known
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
    if (map['user_location'] != null) {
      user_location = TdApiMap.fromMap(map['user_location']) as Location;
    }
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

/// A new incoming callback query; for bots only 
class UpdateNewCallbackQuery extends Update {
  String get tdType => 'updateNewCallbackQuery';

  String? extra;
  int? client_id;

  /// Unique query identifier 
  int64? id;

  /// Identifier of the user who sent the query
  int53? sender_user_id;

  /// Identifier of the chat where the query was sent 
  int53? chat_id;

  /// Identifier of the message, from which the query originated
  int53? message_id;

  /// Identifier that uniquely corresponds to the chat to which the message was sent 
  int64? chat_instance;

  /// Query payload
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
    if (map['payload'] != null) {
      payload = TdApiMap.fromMap(map['payload']) as CallbackQueryPayload;
    }
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

/// A new incoming callback query from a message sent via a bot; for bots only 
class UpdateNewInlineCallbackQuery extends Update {
  String get tdType => 'updateNewInlineCallbackQuery';

  String? extra;
  int? client_id;

  /// Unique query identifier 
  int64? id;

  /// Identifier of the user who sent the query 
  int53? sender_user_id;

  /// Identifier of the inline message, from which the query originated
  string? inline_message_id;

  /// An identifier uniquely corresponding to the chat a message was sent to 
  int64? chat_instance;

  /// Query payload
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
    if (map['payload'] != null) {
      payload = TdApiMap.fromMap(map['payload']) as CallbackQueryPayload;
    }
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

/// A new incoming shipping query; for bots only. Only for invoices with flexible price 
class UpdateNewShippingQuery extends Update {
  String get tdType => 'updateNewShippingQuery';

  String? extra;
  int? client_id;

  /// Unique query identifier 
  int64? id;

  /// Identifier of the user who sent the query 
  int53? sender_user_id;

  /// Invoice payload 
  string? invoice_payload;

  /// User shipping address
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
    if (map['shipping_address'] != null) {
      shipping_address = TdApiMap.fromMap(map['shipping_address']) as Address;
    }
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

/// A new incoming pre-checkout query; for bots only. Contains full information about a checkout 
class UpdateNewPreCheckoutQuery extends Update {
  String get tdType => 'updateNewPreCheckoutQuery';

  String? extra;
  int? client_id;

  /// Unique query identifier 
  int64? id;

  /// Identifier of the user who sent the query 
  int53? sender_user_id;

  /// Currency for the product price 
  string? currency;

  /// Total price for the product, in the smallest units of the currency
  int53? total_amount;

  /// Invoice payload 
  bytes? invoice_payload;

  /// Identifier of a shipping option chosen by the user; may be empty if not applicable 
  string? shipping_option_id;

  /// Information about the order; may be null
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
    if (map['order_info'] != null) {
      order_info = TdApiMap.fromMap(map['order_info']) as OrderInfo;
    }
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

/// A new incoming event; for bots only 
class UpdateNewCustomEvent extends Update {
  String get tdType => 'updateNewCustomEvent';

  String? extra;
  int? client_id;

  /// A JSON-serialized event
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

/// A new incoming query; for bots only 
class UpdateNewCustomQuery extends Update {
  String get tdType => 'updateNewCustomQuery';

  String? extra;
  int? client_id;

  /// The query identifier 
  int64? id;

  /// JSON-serialized query data 
  string? data;

  /// Query timeout
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

/// A poll was updated; for bots only 
class UpdatePoll extends Update {
  String get tdType => 'updatePoll';

  String? extra;
  int? client_id;

  /// New data about the poll
  Poll? poll;

  UpdatePoll({
    this.extra,
    this.client_id,
    this.poll,
  });

  UpdatePoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['poll'] != null) {
      poll = TdApiMap.fromMap(map['poll']) as Poll;
    }
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

/// A user changed the answer to a poll; for bots only 
class UpdatePollAnswer extends Update {
  String get tdType => 'updatePollAnswer';

  String? extra;
  int? client_id;

  /// Unique poll identifier 
  int64? poll_id;

  /// The user, who changed the answer to the poll 
  int53? user_id;

  /// 0-based identifiers of answer options, chosen by the user
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
    if (map['option_ids'] != null) {
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

/// User rights changed in a chat; for bots only 
class UpdateChatMember extends Update {
  String get tdType => 'updateChatMember';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Identifier of the user, changing the rights
  int53? actor_user_id;

  /// Point in time (Unix timestamp) when the user rights was changed 
  int32? date;

  /// If user has joined the chat using an invite link, the invite link; may be null
  ChatInviteLink? invite_link;

  /// Previous chat member 
  ChatMember? old_chat_member;

  /// New chat member
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
    if (map['invite_link'] != null) {
      invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    }
    if (map['old_chat_member'] != null) {
      old_chat_member = TdApiMap.fromMap(map['old_chat_member']) as ChatMember;
    }
    if (map['new_chat_member'] != null) {
      new_chat_member = TdApiMap.fromMap(map['new_chat_member']) as ChatMember;
    }
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

/// A user sent a join request to a chat; for bots only 
class UpdateNewChatJoinRequest extends Update {
  String get tdType => 'updateNewChatJoinRequest';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Join request 
  ChatJoinRequest? request;

  /// The invite link, which was used to send join request; may be null
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
    if (map['request'] != null) {
      request = TdApiMap.fromMap(map['request']) as ChatJoinRequest;
    }
    if (map['invite_link'] != null) {
      invite_link = TdApiMap.fromMap(map['invite_link']) as ChatInviteLink;
    }
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

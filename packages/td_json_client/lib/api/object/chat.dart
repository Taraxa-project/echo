import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_type.dart';
import 'package:td_json_client/api/object/chat_photo_info.dart';
import 'package:td_json_client/api/object/chat_permissions.dart';
import 'package:td_json_client/api/object/message.dart';
import 'package:td_json_client/api/object/chat_position.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/chat_notification_settings.dart';
import 'package:td_json_client/api/object/chat_action_bar.dart';
import 'package:td_json_client/api/object/video_chat.dart';
import 'package:td_json_client/api/object/chat_join_requests_info.dart';
import 'package:td_json_client/api/object/draft_message.dart';


/// A chat. (Can be a private chat, basic group, supergroup, or secret chat)
class Chat extends TdObject {
  String get tdType => 'chat';


  /// Chat unique identifier
  int53? id;

  /// Type of the chat
  ChatType? type;

  /// Chat title
  string? title;

  /// Chat photo; may be null
  ChatPhotoInfo? photo;

  /// Actions that non-administrator chat members are allowed to take in the chat
  ChatPermissions? permissions;

  /// Last message in the chat; may be null
  Message? last_message;

  /// Positions of the chat in chat lists
  vector<ChatPosition>? positions;

  /// Identifier of a user or chat that is selected to send messages in the chat; may be null if the user can't change message sender
  MessageSender? message_sender_id;

  /// True, if chat content can't be saved locally, forwarded, or copied
  Bool? has_protected_content;

  /// True, if the chat is marked as unread
  Bool? is_marked_as_unread;

  /// True, if the chat is blocked by the current user and private messages from the chat can't be received
  Bool? is_blocked;

  /// True, if the chat has scheduled messages
  Bool? has_scheduled_messages;

  /// True, if the chat messages can be deleted only for the current user while other users will continue to see the messages
  Bool? can_be_deleted_only_for_self;

  /// True, if the chat messages can be deleted for all users
  Bool? can_be_deleted_for_all_users;

  /// True, if the chat can be reported to Telegram moderators through reportChat or reportChatPhoto
  Bool? can_be_reported;

  /// Default value of the disable_notification parameter, used when a message is sent to the chat
  Bool? default_disable_notification;

  /// Number of unread messages in the chat
  int32? unread_count;

  /// Identifier of the last read incoming message
  int53? last_read_inbox_message_id;

  /// Identifier of the last read outgoing message
  int53? last_read_outbox_message_id;

  /// Number of unread messages with a mention/reply in the chat
  int32? unread_mention_count;

  /// Notification settings for this chat
  ChatNotificationSettings? notification_settings;

  /// Current message Time To Live setting (self-destruct timer) for the chat; 0 if not defined. TTL is counted from the time message or its content is viewed in secret chats and from the send date in other chats
  int32? message_ttl;

  /// If non-empty, name of a theme, set for the chat
  string? theme_name;

  /// Information about actions which must be possible to do through the chat action bar; may be null
  ChatActionBar? action_bar;

  /// Information about video chat of the chat
  VideoChat? video_chat;

  /// Information about pending join requests; may be null
  ChatJoinRequestsInfo? pending_join_requests;

  /// Identifier of the message from which reply markup needs to be used; 0 if there is no default custom reply markup in the chat
  int53? reply_markup_message_id;

  /// A draft of a message in the chat; may be null
  DraftMessage? draft_message;

  /// Application-specific data associated with the chat. (For example, the chat scroll position or local chat notification settings can be stored here.) Persistent if the message database is used
  string? client_data;

  Chat({
    super.extra,
    super.client_id,
    this.id,
    this.type,
    this.title,
    this.photo,
    this.permissions,
    this.last_message,
    this.positions,
    this.message_sender_id,
    this.has_protected_content,
    this.is_marked_as_unread,
    this.is_blocked,
    this.has_scheduled_messages,
    this.can_be_deleted_only_for_self,
    this.can_be_deleted_for_all_users,
    this.can_be_reported,
    this.default_disable_notification,
    this.unread_count,
    this.last_read_inbox_message_id,
    this.last_read_outbox_message_id,
    this.unread_mention_count,
    this.notification_settings,
    this.message_ttl,
    this.theme_name,
    this.action_bar,
    this.video_chat,
    this.pending_join_requests,
    this.reply_markup_message_id,
    this.draft_message,
    this.client_data,
  });

  Chat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as ChatType;
    }
    title = map['title'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhotoInfo;
    }
    if (map['permissions'] != null) {
      permissions = TdApiMap.fromMap(map['permissions']) as ChatPermissions;
    }
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
    if (map['message_sender_id'] != null) {
      message_sender_id = TdApiMap.fromMap(map['message_sender_id']) as MessageSender;
    }
    has_protected_content = map['has_protected_content'];
    is_marked_as_unread = map['is_marked_as_unread'];
    is_blocked = map['is_blocked'];
    has_scheduled_messages = map['has_scheduled_messages'];
    can_be_deleted_only_for_self = map['can_be_deleted_only_for_self'];
    can_be_deleted_for_all_users = map['can_be_deleted_for_all_users'];
    can_be_reported = map['can_be_reported'];
    default_disable_notification = map['default_disable_notification'];
    unread_count = map['unread_count'];
    last_read_inbox_message_id = map['last_read_inbox_message_id'];
    last_read_outbox_message_id = map['last_read_outbox_message_id'];
    unread_mention_count = map['unread_mention_count'];
    if (map['notification_settings'] != null) {
      notification_settings = TdApiMap.fromMap(map['notification_settings']) as ChatNotificationSettings;
    }
    message_ttl = map['message_ttl'];
    theme_name = map['theme_name'];
    if (map['action_bar'] != null) {
      action_bar = TdApiMap.fromMap(map['action_bar']) as ChatActionBar;
    }
    if (map['video_chat'] != null) {
      video_chat = TdApiMap.fromMap(map['video_chat']) as VideoChat;
    }
    if (map['pending_join_requests'] != null) {
      pending_join_requests = TdApiMap.fromMap(map['pending_join_requests']) as ChatJoinRequestsInfo;
    }
    reply_markup_message_id = map['reply_markup_message_id'];
    if (map['draft_message'] != null) {
      draft_message = TdApiMap.fromMap(map['draft_message']) as DraftMessage;
    }
    client_data = map['client_data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'permissions': permissions?.toMap(skipNulls: skipNulls),
      'last_message': last_message?.toMap(skipNulls: skipNulls),
      'positions': positions?.toMap(skipNulls: skipNulls),
      'message_sender_id': message_sender_id?.toMap(skipNulls: skipNulls),
      'has_protected_content': has_protected_content?.toMap(skipNulls: skipNulls),
      'is_marked_as_unread': is_marked_as_unread?.toMap(skipNulls: skipNulls),
      'is_blocked': is_blocked?.toMap(skipNulls: skipNulls),
      'has_scheduled_messages': has_scheduled_messages?.toMap(skipNulls: skipNulls),
      'can_be_deleted_only_for_self': can_be_deleted_only_for_self?.toMap(skipNulls: skipNulls),
      'can_be_deleted_for_all_users': can_be_deleted_for_all_users?.toMap(skipNulls: skipNulls),
      'can_be_reported': can_be_reported?.toMap(skipNulls: skipNulls),
      'default_disable_notification': default_disable_notification?.toMap(skipNulls: skipNulls),
      'unread_count': unread_count?.toMap(skipNulls: skipNulls),
      'last_read_inbox_message_id': last_read_inbox_message_id?.toMap(skipNulls: skipNulls),
      'last_read_outbox_message_id': last_read_outbox_message_id?.toMap(skipNulls: skipNulls),
      'unread_mention_count': unread_mention_count?.toMap(skipNulls: skipNulls),
      'notification_settings': notification_settings?.toMap(skipNulls: skipNulls),
      'message_ttl': message_ttl?.toMap(skipNulls: skipNulls),
      'theme_name': theme_name?.toMap(skipNulls: skipNulls),
      'action_bar': action_bar?.toMap(skipNulls: skipNulls),
      'video_chat': video_chat?.toMap(skipNulls: skipNulls),
      'pending_join_requests': pending_join_requests?.toMap(skipNulls: skipNulls),
      'reply_markup_message_id': reply_markup_message_id?.toMap(skipNulls: skipNulls),
      'draft_message': draft_message?.toMap(skipNulls: skipNulls),
      'client_data': client_data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

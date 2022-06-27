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

class Chat extends TdObject {
  String get tdType => 'chat';

  String? extra;
  int? client_id;
  int53? id;
  ChatType? type;
  string? title;
  ChatPhotoInfo? photo;
  ChatPermissions? permissions;
  Message? last_message;
  vector<ChatPosition>? positions;
  MessageSender? message_sender_id;
  Bool? has_protected_content;
  Bool? is_marked_as_unread;
  Bool? is_blocked;
  Bool? has_scheduled_messages;
  Bool? can_be_deleted_only_for_self;
  Bool? can_be_deleted_for_all_users;
  Bool? can_be_reported;
  Bool? default_disable_notification;
  int32? unread_count;
  int53? last_read_inbox_message_id;
  int53? last_read_outbox_message_id;
  int32? unread_mention_count;
  int32? unread_reaction_count;
  ChatNotificationSettings? notification_settings;
  vector<string>? available_reactions;
  int32? message_ttl;
  string? theme_name;
  ChatActionBar? action_bar;
  VideoChat? video_chat;
  ChatJoinRequestsInfo? pending_join_requests;
  int53? reply_markup_message_id;
  DraftMessage? draft_message;
  string? client_data;

  Chat({
    this.extra,
    this.client_id,
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
    this.unread_reaction_count,
    this.notification_settings,
    this.available_reactions,
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
    type = TdApiMap.fromMap(map['type']) as ChatType;
    title = map['title'];
    photo = TdApiMap.fromMap(map['photo']) as ChatPhotoInfo;
    permissions = TdApiMap.fromMap(map['permissions']) as ChatPermissions;
    last_message = TdApiMap.fromMap(map['last_message']) as Message;
    if (map['positions']) {
      positions = [];
      for (var someValue in map['positions']) {
        positions?.add(TdApiMap.fromMap(someValue) as ChatPosition);
      }
    }
    message_sender_id = TdApiMap.fromMap(map['message_sender_id']) as MessageSender;
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
    unread_reaction_count = map['unread_reaction_count'];
    notification_settings = TdApiMap.fromMap(map['notification_settings']) as ChatNotificationSettings;
    if (map['available_reactions']) {
      available_reactions = [];
      for (var someValue in map['available_reactions']) {
        available_reactions?.add(someValue);
      }
    }
    message_ttl = map['message_ttl'];
    theme_name = map['theme_name'];
    action_bar = TdApiMap.fromMap(map['action_bar']) as ChatActionBar;
    video_chat = TdApiMap.fromMap(map['video_chat']) as VideoChat;
    pending_join_requests = TdApiMap.fromMap(map['pending_join_requests']) as ChatJoinRequestsInfo;
    reply_markup_message_id = map['reply_markup_message_id'];
    draft_message = TdApiMap.fromMap(map['draft_message']) as DraftMessage;
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
      'unread_reaction_count': unread_reaction_count?.toMap(skipNulls: skipNulls),
      'notification_settings': notification_settings?.toMap(skipNulls: skipNulls),
      'available_reactions': available_reactions?.toMap(skipNulls: skipNulls),
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

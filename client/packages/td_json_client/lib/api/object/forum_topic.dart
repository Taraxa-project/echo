import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/forum_topic_info.dart';
import 'package:td_json_client/api/object/message.dart';
import 'package:td_json_client/api/object/chat_notification_settings.dart';
import 'package:td_json_client/api/object/draft_message.dart';


/// Describes a forum topic
class ForumTopic extends TdObject {
  String get tdType => 'forumTopic';


  /// Basic information about the topic
  ForumTopicInfo? info;

  /// Last message in the topic; may be null if unknown
  Message? last_message;

  /// True, if the topic is pinned in the topic list
  Bool? is_pinned;

  /// Number of unread messages in the topic
  int32? unread_count;

  /// Identifier of the last read incoming message
  int53? last_read_inbox_message_id;

  /// Identifier of the last read outgoing message
  int53? last_read_outbox_message_id;

  /// Number of unread messages with a mention/reply in the topic
  int32? unread_mention_count;

  /// Number of messages with unread reactions in the topic
  int32? unread_reaction_count;

  /// Notification settings for the topic
  ChatNotificationSettings? notification_settings;

  /// A draft of a message in the topic; may be null
  DraftMessage? draft_message;

  ForumTopic({
    super.extra,
    super.client_id,
    this.info,
    this.last_message,
    this.is_pinned,
    this.unread_count,
    this.last_read_inbox_message_id,
    this.last_read_outbox_message_id,
    this.unread_mention_count,
    this.unread_reaction_count,
    this.notification_settings,
    this.draft_message,
  });

  ForumTopic.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['info'] != null) {
      info = TdApiMap.fromMap(map['info']) as ForumTopicInfo;
    }
    if (map['last_message'] != null) {
      last_message = TdApiMap.fromMap(map['last_message']) as Message;
    }
    is_pinned = map['is_pinned'];
    unread_count = map['unread_count'];
    last_read_inbox_message_id = map['last_read_inbox_message_id'];
    last_read_outbox_message_id = map['last_read_outbox_message_id'];
    unread_mention_count = map['unread_mention_count'];
    unread_reaction_count = map['unread_reaction_count'];
    if (map['notification_settings'] != null) {
      notification_settings = TdApiMap.fromMap(map['notification_settings']) as ChatNotificationSettings;
    }
    if (map['draft_message'] != null) {
      draft_message = TdApiMap.fromMap(map['draft_message']) as DraftMessage;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'info': info?.toMap(skipNulls: skipNulls),
      'last_message': last_message?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
      'unread_count': unread_count?.toMap(skipNulls: skipNulls),
      'last_read_inbox_message_id': last_read_inbox_message_id?.toMap(skipNulls: skipNulls),
      'last_read_outbox_message_id': last_read_outbox_message_id?.toMap(skipNulls: skipNulls),
      'unread_mention_count': unread_mention_count?.toMap(skipNulls: skipNulls),
      'unread_reaction_count': unread_reaction_count?.toMap(skipNulls: skipNulls),
      'notification_settings': notification_settings?.toMap(skipNulls: skipNulls),
      'draft_message': draft_message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

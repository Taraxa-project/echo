import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about notification settings for several chats
class ScopeNotificationSettings extends TdObject {
  String get tdType => 'scopeNotificationSettings';

  /// Time left before notifications will be unmuted, in seconds
  int32? mute_for;

  /// Identifier of the notification sound to be played; 0 if sound is disabled
  int64? sound_id;

  /// True, if message content must be displayed in notifications
  Bool? show_preview;

  /// If true, mute_stories is ignored and stories are unmuted only for the first 5 chats from topChatCategoryUsers
  Bool? use_default_mute_stories;

  /// True, if story notifications are received without sound
  Bool? mute_stories;

  /// Identifier of the notification sound to be played for stories; 0 if sound is disabled
  int64? story_sound_id;

  /// True, if the sender of stories must be displayed in notifications
  Bool? show_story_sender;

  /// True, if notifications for incoming pinned messages will be created as for an ordinary unread message
  Bool? disable_pinned_message_notifications;

  /// True, if notifications for messages with mentions will be created as for an ordinary unread message
  Bool? disable_mention_notifications;

  ScopeNotificationSettings({
    super.extra,
    super.client_id,
    this.mute_for,
    this.sound_id,
    this.show_preview,
    this.use_default_mute_stories,
    this.mute_stories,
    this.story_sound_id,
    this.show_story_sender,
    this.disable_pinned_message_notifications,
    this.disable_mention_notifications,
  });

  ScopeNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    mute_for = map['mute_for'];
    sound_id = map['sound_id'];
    show_preview = map['show_preview'];
    use_default_mute_stories = map['use_default_mute_stories'];
    mute_stories = map['mute_stories'];
    story_sound_id = map['story_sound_id'];
    show_story_sender = map['show_story_sender'];
    disable_pinned_message_notifications = map['disable_pinned_message_notifications'];
    disable_mention_notifications = map['disable_mention_notifications'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'mute_for': mute_for?.toMap(skipNulls: skipNulls),
      'sound_id': sound_id?.toMap(skipNulls: skipNulls),
      'show_preview': show_preview?.toMap(skipNulls: skipNulls),
      'use_default_mute_stories': use_default_mute_stories?.toMap(skipNulls: skipNulls),
      'mute_stories': mute_stories?.toMap(skipNulls: skipNulls),
      'story_sound_id': story_sound_id?.toMap(skipNulls: skipNulls),
      'show_story_sender': show_story_sender?.toMap(skipNulls: skipNulls),
      'disable_pinned_message_notifications': disable_pinned_message_notifications?.toMap(skipNulls: skipNulls),
      'disable_mention_notifications': disable_mention_notifications?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

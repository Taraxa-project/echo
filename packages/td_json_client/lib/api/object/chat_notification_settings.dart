import 'package:td_json_client/api/base.dart';


/// Contains information about notification settings for a chat
class ChatNotificationSettings extends TdObject {
  String get tdType => 'chatNotificationSettings';


  /// If true, mute_for is ignored and the value for the relevant type of chat is used instead 
  Bool? use_default_mute_for;

  /// Time left before notifications will be unmuted, in seconds
  int32? mute_for;

  /// If true, the value for the relevant type of chat is used instead of sound_id 
  Bool? use_default_sound;

  /// Identifier of the notification sound to be played; 0 if sound is disabled
  int64? sound_id;

  /// If true, show_preview is ignored and the value for the relevant type of chat is used instead 
  Bool? use_default_show_preview;

  /// True, if message content must be displayed in notifications
  Bool? show_preview;

  /// If true, disable_pinned_message_notifications is ignored and the value for the relevant type of chat is used instead 
  Bool? use_default_disable_pinned_message_notifications;

  /// If true, notifications for incoming pinned messages will be created as for an ordinary unread message
  Bool? disable_pinned_message_notifications;

  /// If true, disable_mention_notifications is ignored and the value for the relevant type of chat is used instead 
  Bool? use_default_disable_mention_notifications;

  /// If true, notifications for messages with mentions will be created as for an ordinary unread message
  Bool? disable_mention_notifications;

  ChatNotificationSettings({
    super.extra,
    super.client_id,
    this.use_default_mute_for,
    this.mute_for,
    this.use_default_sound,
    this.sound_id,
    this.use_default_show_preview,
    this.show_preview,
    this.use_default_disable_pinned_message_notifications,
    this.disable_pinned_message_notifications,
    this.use_default_disable_mention_notifications,
    this.disable_mention_notifications,
  });

  ChatNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    use_default_mute_for = map['use_default_mute_for'];
    mute_for = map['mute_for'];
    use_default_sound = map['use_default_sound'];
    sound_id = map['sound_id'];
    use_default_show_preview = map['use_default_show_preview'];
    show_preview = map['show_preview'];
    use_default_disable_pinned_message_notifications = map['use_default_disable_pinned_message_notifications'];
    disable_pinned_message_notifications = map['disable_pinned_message_notifications'];
    use_default_disable_mention_notifications = map['use_default_disable_mention_notifications'];
    disable_mention_notifications = map['disable_mention_notifications'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'use_default_mute_for': use_default_mute_for?.toMap(skipNulls: skipNulls),
      'mute_for': mute_for?.toMap(skipNulls: skipNulls),
      'use_default_sound': use_default_sound?.toMap(skipNulls: skipNulls),
      'sound_id': sound_id?.toMap(skipNulls: skipNulls),
      'use_default_show_preview': use_default_show_preview?.toMap(skipNulls: skipNulls),
      'show_preview': show_preview?.toMap(skipNulls: skipNulls),
      'use_default_disable_pinned_message_notifications': use_default_disable_pinned_message_notifications?.toMap(skipNulls: skipNulls),
      'disable_pinned_message_notifications': disable_pinned_message_notifications?.toMap(skipNulls: skipNulls),
      'use_default_disable_mention_notifications': use_default_disable_mention_notifications?.toMap(skipNulls: skipNulls),
      'disable_mention_notifications': disable_mention_notifications?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

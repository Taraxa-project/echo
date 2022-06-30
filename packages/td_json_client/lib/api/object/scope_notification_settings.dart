import 'package:td_json_client/api/base.dart';


/// Contains information about notification settings for several chats
class ScopeNotificationSettings extends TdObject {
  String get tdType => 'scopeNotificationSettings';


  /// Time left before notifications will be unmuted, in seconds
  int32? mute_for;

  /// The name of an audio file to be used for notification sounds; only applies to iOS applications
  string? sound;

  /// True, if message content must be displayed in notifications
  Bool? show_preview;

  /// True, if notifications for incoming pinned messages will be created as for an ordinary unread message
  Bool? disable_pinned_message_notifications;

  /// True, if notifications for messages with mentions will be created as for an ordinary unread message
  Bool? disable_mention_notifications;

  ScopeNotificationSettings({
    super.extra,
    super.client_id,
    this.mute_for,
    this.sound,
    this.show_preview,
    this.disable_pinned_message_notifications,
    this.disable_mention_notifications,
  });

  ScopeNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    mute_for = map['mute_for'];
    sound = map['sound'];
    show_preview = map['show_preview'];
    disable_pinned_message_notifications = map['disable_pinned_message_notifications'];
    disable_mention_notifications = map['disable_mention_notifications'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'mute_for': mute_for?.toMap(skipNulls: skipNulls),
      'sound': sound?.toMap(skipNulls: skipNulls),
      'show_preview': show_preview?.toMap(skipNulls: skipNulls),
      'disable_pinned_message_notifications': disable_pinned_message_notifications?.toMap(skipNulls: skipNulls),
      'disable_mention_notifications': disable_mention_notifications?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

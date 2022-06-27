import 'package:td_json_client/api/base.dart';

class ChatNotificationSettings extends TdObject {
  String get tdType => 'chatNotificationSettings';

  string? extra;
  int? client_id;
  Bool? use_default_mute_for;
  int32? mute_for;
  Bool? use_default_sound;
  string? sound;
  Bool? use_default_show_preview;
  Bool? show_preview;
  Bool? use_default_disable_pinned_message_notifications;
  Bool? disable_pinned_message_notifications;
  Bool? use_default_disable_mention_notifications;
  Bool? disable_mention_notifications;

  ChatNotificationSettings({
    this.extra,
    this.client_id,
    this.use_default_mute_for,
    this.mute_for,
    this.use_default_sound,
    this.sound,
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
    sound = map['sound'];
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
      'sound': sound?.toMap(skipNulls: skipNulls),
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

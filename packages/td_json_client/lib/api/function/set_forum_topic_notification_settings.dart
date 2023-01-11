import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_notification_settings.dart';


/// Changes the notification settings of a forum topic
class SetForumTopicNotificationSettings extends TdFunction {
  String get tdType => 'setForumTopicNotificationSettings';
  String get tdReturnType => 'Ok';


  /// Chat identifier
  int53? chat_id;

  /// Message thread identifier of the forum topic
  int53? message_thread_id;

  /// New notification settings for the forum topic. If the topic is muted for more than 366 days, it is considered to be muted forever
  ChatNotificationSettings? notification_settings;

  SetForumTopicNotificationSettings({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.notification_settings,
  });

  SetForumTopicNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
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
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'notification_settings': notification_settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

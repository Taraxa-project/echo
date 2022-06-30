import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_notification_settings.dart';


/// Changes the notification settings of a chat. Notification settings of a chat with the current user (Saved Messages) can't be changed
class SetChatNotificationSettings extends TdFunction {
  String get tdType => 'setChatNotificationSettings';
  String get tdReturnType => 'Ok';


  /// Chat identifier 
  int53? chat_id;

  /// New notification settings for the chat. If the chat is muted for more than 1 week, it is considered to be muted forever
  ChatNotificationSettings? notification_settings;

  SetChatNotificationSettings({
    super.extra,
    super.client_id,
    this.chat_id,
    this.notification_settings,
  });

  SetChatNotificationSettings.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_notification_settings.dart';

class SetChatNotificationSettings extends TdFunction {
  String get tdType => 'setChatNotificationSettings';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  ChatNotificationSettings? notification_settings;

  SetChatNotificationSettings({
    this.extra,
    this.client_id,
    this.chat_id,
    this.notification_settings,
  });

  SetChatNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    notification_settings = TdApiMap.fromMap(map['notification_settings']) as ChatNotificationSettings;
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

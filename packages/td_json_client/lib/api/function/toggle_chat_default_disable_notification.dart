import 'package:td_json_client/api/base.dart';


/// Changes the value of the default disable_notification parameter, used when a message is sent to a chat 
class ToggleChatDefaultDisableNotification extends TdFunction {
  String get tdType => 'toggleChatDefaultDisableNotification';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// New value of default_disable_notification
  Bool? default_disable_notification;

  ToggleChatDefaultDisableNotification({
    this.extra,
    this.client_id,
    this.chat_id,
    this.default_disable_notification,
  });

  ToggleChatDefaultDisableNotification.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    default_disable_notification = map['default_disable_notification'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'default_disable_notification': default_disable_notification?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

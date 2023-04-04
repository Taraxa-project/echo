import 'package:td_json_client/src/td_api/td.dart';

/// Resets all notification settings to their default values. By default, all chats are unmuted and message previews are shown
class ResetAllNotificationSettings extends TdFunction {
  String get tdType => 'resetAllNotificationSettings';
  String get tdReturnType => 'Ok';

  ResetAllNotificationSettings({
    super.extra,
    super.client_id,
  });

  ResetAllNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

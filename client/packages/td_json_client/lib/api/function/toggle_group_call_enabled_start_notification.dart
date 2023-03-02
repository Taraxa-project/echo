import 'package:td_json_client/api/base.dart';

/// Toggles whether the current user will receive a notification when the group call will start; scheduled group calls only
class ToggleGroupCallEnabledStartNotification extends TdFunction {
  String get tdType => 'toggleGroupCallEnabledStartNotification';
  String get tdReturnType => 'Ok';

  /// Group call identifier
  int32? group_call_id;

  /// New value of the enabled_start_notification setting
  Bool? enabled_start_notification;

  ToggleGroupCallEnabledStartNotification({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.enabled_start_notification,
  });

  ToggleGroupCallEnabledStartNotification.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    enabled_start_notification = map['enabled_start_notification'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'enabled_start_notification':
          enabled_start_notification?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

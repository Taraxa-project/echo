import 'package:td_json_client/api/base.dart';

class ToggleGroupCallEnabledStartNotification extends TdFunction {
  String get tdType => 'toggleGroupCallEnabledStartNotification';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? group_call_id;
  Bool? enabled_start_notification;

  ToggleGroupCallEnabledStartNotification({
    this.extra,
    this.client_id,
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
      'enabled_start_notification': enabled_start_notification?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

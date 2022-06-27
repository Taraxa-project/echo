import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/notification_settings_scope.dart';
import 'package:td_json_client/api/object/scope_notification_settings.dart';

class SetScopeNotificationSettings extends TdFunction {
  String get tdType => 'setScopeNotificationSettings';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  NotificationSettingsScope? scope;
  ScopeNotificationSettings? notification_settings;

  SetScopeNotificationSettings({
    this.extra,
    this.client_id,
    this.scope,
    this.notification_settings,
  });

  SetScopeNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    scope = TdApiMap.fromMap(map['scope']) as NotificationSettingsScope;
    notification_settings = TdApiMap.fromMap(map['notification_settings']) as ScopeNotificationSettings;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'scope': scope?.toMap(skipNulls: skipNulls),
      'notification_settings': notification_settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

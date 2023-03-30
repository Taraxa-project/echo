import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/notification_settings_scope.dart';
import 'package:td_json_client/src/td_api/object/scope_notification_settings.dart';

/// Changes notification settings for chats of a given type
class SetScopeNotificationSettings extends TdFunction {
  String get tdType => 'setScopeNotificationSettings';
  String get tdReturnType => 'Ok';

  /// Types of chats for which to change the notification settings
  NotificationSettingsScope? scope;

  /// The new notification settings for the given scope
  ScopeNotificationSettings? notification_settings;

  SetScopeNotificationSettings({
    super.extra,
    super.client_id,
    this.scope,
    this.notification_settings,
  });

  SetScopeNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['scope'] != null) {
      scope = TdApiMap.fromMap(map['scope']) as NotificationSettingsScope;
    }
    if (map['notification_settings'] != null) {
      notification_settings = TdApiMap.fromMap(map['notification_settings'])
          as ScopeNotificationSettings;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'scope': scope?.toMap(skipNulls: skipNulls),
      'notification_settings':
          notification_settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

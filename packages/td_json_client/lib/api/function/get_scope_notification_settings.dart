import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/notification_settings_scope.dart';


/// Returns the notification settings for chats of a given type 
class GetScopeNotificationSettings extends TdFunction {
  String get tdType => 'getScopeNotificationSettings';
  String get tdReturnType => 'ScopeNotificationSettings';

  String? extra;
  int? client_id;

  /// Types of chats for which to return the notification settings information
  NotificationSettingsScope? scope;

  GetScopeNotificationSettings({
    this.extra,
    this.client_id,
    this.scope,
  });

  GetScopeNotificationSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['scope'] != null) {
      scope = TdApiMap.fromMap(map['scope']) as NotificationSettingsScope;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'scope': scope?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

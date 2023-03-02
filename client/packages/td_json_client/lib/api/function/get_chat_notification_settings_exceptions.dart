import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/notification_settings_scope.dart';


/// Returns list of chats with non-default notification settings
class GetChatNotificationSettingsExceptions extends TdFunction {
  String get tdType => 'getChatNotificationSettingsExceptions';
  String get tdReturnType => 'Chats';


  /// If specified, only chats from the scope will be returned; pass null to return chats from all scopes
  NotificationSettingsScope? scope;

  /// Pass true to include in the response chats with only non-default sound
  Bool? compare_sound;

  GetChatNotificationSettingsExceptions({
    super.extra,
    super.client_id,
    this.scope,
    this.compare_sound,
  });

  GetChatNotificationSettingsExceptions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['scope'] != null) {
      scope = TdApiMap.fromMap(map['scope']) as NotificationSettingsScope;
    }
    compare_sound = map['compare_sound'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'scope': scope?.toMap(skipNulls: skipNulls),
      'compare_sound': compare_sound?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

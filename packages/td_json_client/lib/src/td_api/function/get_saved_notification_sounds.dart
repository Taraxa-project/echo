import 'package:td_json_client/src/td_api/td.dart';

/// Returns list of saved notification sounds. If a sound isn't in the list, then default sound needs to be used
class GetSavedNotificationSounds extends TdFunction {
  String get tdType => 'getSavedNotificationSounds';
  String get tdReturnType => 'NotificationSounds';

  GetSavedNotificationSounds({
    super.extra,
    super.client_id,
  });

  GetSavedNotificationSounds.fromMap(Map<String, dynamic> map) {
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

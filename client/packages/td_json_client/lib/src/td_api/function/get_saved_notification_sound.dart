import 'package:td_json_client/src/td_api/td.dart';

/// Returns saved notification sound by its identifier. Returns a 404 error if there is no saved notification sound with the specified identifier
class GetSavedNotificationSound extends TdFunction {
  String get tdType => 'getSavedNotificationSound';
  String get tdReturnType => 'NotificationSounds';

  /// Identifier of the notification sound
  int64? notification_sound_id;

  GetSavedNotificationSound({
    super.extra,
    super.client_id,
    this.notification_sound_id,
  });

  GetSavedNotificationSound.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    notification_sound_id = map['notification_sound_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'notification_sound_id': notification_sound_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

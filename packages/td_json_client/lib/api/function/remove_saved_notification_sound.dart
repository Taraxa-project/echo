import 'package:td_json_client/api/base.dart';

class RemoveSavedNotificationSound extends TdFunction {
  String get tdType => 'removeSavedNotificationSound';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int64? notification_sound_id;

  RemoveSavedNotificationSound({
    this.extra,
    this.client_id,
    this.notification_sound_id,
  });

  RemoveSavedNotificationSound.fromMap(Map<String, dynamic> map) {
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

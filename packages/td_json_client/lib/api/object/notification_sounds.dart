import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/notification_sound.dart';

class NotificationSounds extends TdObject {
  String get tdType => 'notificationSounds';

  string? extra;
  int? client_id;
  vector<NotificationSound>? notification_sounds;

  NotificationSounds({
    this.extra,
    this.client_id,
    this.notification_sounds,
  });

  NotificationSounds.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['notification_sounds']) {
      notification_sounds = [];
      for (var someValue in map['notification_sounds']) {
        notification_sounds?.add(TdApiMap.fromMap(someValue) as NotificationSound);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'notification_sounds': notification_sounds?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

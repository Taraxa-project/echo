import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/notification_sound.dart';


/// Contains a list of notification sounds 
class NotificationSounds extends TdObject {
  String get tdType => 'notificationSounds';


  /// A list of notification sounds
  vector<NotificationSound>? notification_sounds;

  NotificationSounds({
    super.extra,
    super.client_id,
    this.notification_sounds,
  });

  NotificationSounds.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['notification_sounds'] != null) {
      notification_sounds = [];
      for (var someValue in map['notification_sounds']) {
        if (someValue != null) {
          notification_sounds?.add(TdApiMap.fromMap(someValue) as NotificationSound);
        }
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

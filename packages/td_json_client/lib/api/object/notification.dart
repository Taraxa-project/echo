import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/notification_type.dart';


/// Contains information about a notification 
class Notification extends TdObject {
  String get tdType => 'notification';

  String? extra;
  int? client_id;

  /// Unique persistent identifier of this notification 
  int32? id;

  /// Notification date
  int32? date;

  /// True, if the notification was explicitly sent without sound 
  Bool? is_silent;

  /// Notification type
  NotificationType? type;

  Notification({
    this.extra,
    this.client_id,
    this.id,
    this.date,
    this.is_silent,
    this.type,
  });

  Notification.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    date = map['date'];
    is_silent = map['is_silent'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as NotificationType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'is_silent': is_silent?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

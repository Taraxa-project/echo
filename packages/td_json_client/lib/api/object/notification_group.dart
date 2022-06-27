import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/notification_group_type.dart';
import 'package:td_json_client/api/object/notification.dart';

class NotificationGroup extends TdObject {
  String get tdType => 'notificationGroup';

  String? extra;
  int? client_id;
  int32? id;
  NotificationGroupType? type;
  int53? chat_id;
  int32? total_count;
  vector<Notification>? notifications;

  NotificationGroup({
    this.extra,
    this.client_id,
    this.id,
    this.type,
    this.chat_id,
    this.total_count,
    this.notifications,
  });

  NotificationGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    type = TdApiMap.fromMap(map['type']) as NotificationGroupType;
    chat_id = map['chat_id'];
    total_count = map['total_count'];
    if (map['notifications']) {
      notifications = [];
      for (var someValue in map['notifications']) {
        notifications?.add(TdApiMap.fromMap(someValue) as Notification);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'notifications': notifications?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/notification_group_type.dart';
import 'package:td_json_client/api/object/notification.dart';


/// Describes a group of notifications 
class NotificationGroup extends TdObject {
  String get tdType => 'notificationGroup';


  /// Unique persistent auto-incremented from 1 identifier of the notification group 
  int32? id;

  /// Type of the group
  NotificationGroupType? type;

  /// Identifier of a chat to which all notifications in the group belong
  int53? chat_id;

  /// Total number of active notifications in the group 
  int32? total_count;

  /// The list of active notifications
  vector<Notification>? notifications;

  NotificationGroup({
    super.extra,
    super.client_id,
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
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as NotificationGroupType;
    }
    chat_id = map['chat_id'];
    total_count = map['total_count'];
    if (map['notifications'] != null) {
      notifications = [];
      for (var someValue in map['notifications']) {
        if (someValue != null) {
          notifications?.add(TdApiMap.fromMap(someValue) as Notification);
        }
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

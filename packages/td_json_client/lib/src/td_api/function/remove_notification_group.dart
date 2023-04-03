import 'package:td_json_client/src/td_api/td.dart';

/// Removes a group of active notifications. Needs to be called only if the notification group is removed by the current user
class RemoveNotificationGroup extends TdFunction {
  String get tdType => 'removeNotificationGroup';
  String get tdReturnType => 'Ok';

  /// Notification group identifier
  int32? notification_group_id;

  /// The maximum identifier of removed notifications
  int32? max_notification_id;

  RemoveNotificationGroup({
    super.extra,
    super.client_id,
    this.notification_group_id,
    this.max_notification_id,
  });

  RemoveNotificationGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    notification_group_id = map['notification_group_id'];
    max_notification_id = map['max_notification_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'notification_group_id': notification_group_id?.toMap(skipNulls: skipNulls),
      'max_notification_id': max_notification_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

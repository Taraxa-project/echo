import 'package:td_json_client/src/td_api/td.dart';

/// Removes an active notification from notification list. Needs to be called only if the notification is removed by the current user
class RemoveNotification extends TdFunction {
  String get tdType => 'removeNotification';
  String get tdReturnType => 'Ok';

  /// Identifier of notification group to which the notification belongs
  int32? notification_group_id;

  /// Identifier of removed notification
  int32? notification_id;

  RemoveNotification({
    super.extra,
    super.client_id,
    this.notification_group_id,
    this.notification_id,
  });

  RemoveNotification.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    notification_group_id = map['notification_group_id'];
    notification_id = map['notification_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'notification_group_id': notification_group_id?.toMap(skipNulls: skipNulls),
      'notification_id': notification_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

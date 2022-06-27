import 'package:td_json_client/api/base.dart';

class RemoveNotificationGroup extends TdFunction {
  String get tdType => 'removeNotificationGroup';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int32? notification_group_id;
  int32? max_notification_id;

  RemoveNotificationGroup({
    this.extra,
    this.client_id,
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

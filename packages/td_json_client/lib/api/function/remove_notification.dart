import 'package:td_json_client/api/base.dart';

class RemoveNotification extends TdFunction {
  String get tdType => 'removeNotification';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? notification_group_id;
  int32? notification_id;

  RemoveNotification({
    this.extra,
    this.client_id,
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

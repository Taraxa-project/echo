import 'package:td_json_client/api/base.dart';


/// Handles a push notification. Returns error with code 406 if the push notification is not supported and connection to the server is required to fetch new data. Can be called before authorization
class ProcessPushNotification extends TdFunction {
  String get tdType => 'processPushNotification';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// JSON-encoded push notification payload with all fields sent by the server, and "google.sent_time" and "google.notification.sound" fields added
  string? payload;

  ProcessPushNotification({
    this.extra,
    this.client_id,
    this.payload,
  });

  ProcessPushNotification.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    payload = map['payload'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'payload': payload?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

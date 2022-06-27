import 'package:td_json_client/api/base.dart';

class GetPushReceiverId extends TdFunction {
  String get tdType => 'getPushReceiverId';
  String get tdReturnType => 'PushReceiverId';

  string? extra;
  int? client_id;
  string? payload;

  GetPushReceiverId({
    this.extra,
    this.client_id,
    this.payload,
  });

  GetPushReceiverId.fromMap(Map<String, dynamic> map) {
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
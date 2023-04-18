import 'package:td_json_client/src/td_api/td.dart';

/// Sends call signaling data
class SendCallSignalingData extends TdFunction {
  String get tdType => 'sendCallSignalingData';
  String get tdReturnType => 'Ok';

  /// Call identifier
  int32? call_id;

  /// The data
  bytes? data;

  SendCallSignalingData({
    super.extra,
    super.client_id,
    this.call_id,
    this.data,
  });

  SendCallSignalingData.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call_id = map['call_id'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'call_id': call_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Returns the received bytes; for testing only. This is an offline method. Can be called before authorization
class TestCallBytes extends TdFunction {
  String get tdType => 'testCallBytes';
  String get tdReturnType => 'TestBytes';

  /// Bytes to return
  bytes? x;

  TestCallBytes({
    super.extra,
    super.client_id,
    this.x,
  });

  TestCallBytes.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    x = map['x'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'x': x?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

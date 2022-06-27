import 'package:td_json_client/api/base.dart';

class TestCallBytes extends TdFunction {
  String get tdType => 'testCallBytes';
  String get tdReturnType => 'TestBytes';

  string? extra;
  int? client_id;
  bytes? x;

  TestCallBytes({
    this.extra,
    this.client_id,
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

import 'package:td_json_client/api/base.dart';

class TestCallString extends TdFunction {
  String get tdType => 'testCallString';
  String get tdReturnType => 'TestString';

  String? extra;
  int? client_id;
  string? x;

  TestCallString({
    this.extra,
    this.client_id,
    this.x,
  });

  TestCallString.fromMap(Map<String, dynamic> map) {
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

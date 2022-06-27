import 'package:td_json_client/api/base.dart';

class TestCallVectorInt extends TdFunction {
  String get tdType => 'testCallVectorInt';
  String get tdReturnType => 'TestVectorInt';

  String? extra;
  int? client_id;
  vector<int32>? x;

  TestCallVectorInt({
    this.extra,
    this.client_id,
    this.x,
  });

  TestCallVectorInt.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['x']) {
      x = [];
      for (var someValue in map['x']) {
        x?.add(someValue);
      }
    }
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

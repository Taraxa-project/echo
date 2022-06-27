import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/test_string.dart';

class TestCallVectorStringObject extends TdFunction {
  String get tdType => 'testCallVectorStringObject';
  String get tdReturnType => 'TestVectorStringObject';

  string? extra;
  int? client_id;
  vector<TestString>? x;

  TestCallVectorStringObject({
    this.extra,
    this.client_id,
    this.x,
  });

  TestCallVectorStringObject.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['x']) {
      x = [];
      for (var someValue in map['x']) {
        x?.add(TdApiMap.fromMap(someValue) as TestString);
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

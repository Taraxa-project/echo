import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/test_int.dart';

/// Returns the received vector of objects containing a number; for testing only. This is an offline method. Can be called before authorization
class TestCallVectorIntObject extends TdFunction {
  String get tdType => 'testCallVectorIntObject';
  String get tdReturnType => 'TestVectorIntObject';

  /// Vector of objects to return
  vector<TestInt>? x;

  TestCallVectorIntObject({
    super.extra,
    super.client_id,
    this.x,
  });

  TestCallVectorIntObject.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['x'] != null) {
      x = [];
      for (var someValue in map['x']) {
        if (someValue != null) {
          x?.add(TdApiMap.fromMap(someValue) as TestInt);
        }
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
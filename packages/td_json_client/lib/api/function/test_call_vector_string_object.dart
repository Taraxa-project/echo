import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/test_string.dart';


/// Returns the received vector of objects containing a string; for testing only. This is an offline method. Can be called before authorization 
class TestCallVectorStringObject extends TdFunction {
  String get tdType => 'testCallVectorStringObject';
  String get tdReturnType => 'TestVectorStringObject';

  String? extra;
  int? client_id;

  /// Vector of objects to return
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

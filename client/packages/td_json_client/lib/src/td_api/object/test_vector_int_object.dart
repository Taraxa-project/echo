import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/test_int.dart';

/// A simple object containing a vector of objects that hold a number; for testing only
class TestVectorIntObject extends TdObject {
  String get tdType => 'testVectorIntObject';

  /// Vector of objects
  vector<TestInt>? value;

  TestVectorIntObject({
    super.extra,
    super.client_id,
    this.value,
  });

  TestVectorIntObject.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['value'] != null) {
      value = [];
      for (var someValue in map['value']) {
        if (someValue != null) {
          value?.add(TdApiMap.fromMap(someValue) as TestInt);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

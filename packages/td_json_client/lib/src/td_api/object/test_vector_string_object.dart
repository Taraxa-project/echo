import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/test_string.dart';

/// A simple object containing a vector of objects that hold a string; for testing only
class TestVectorStringObject extends TdObject {
  String get tdType => 'testVectorStringObject';

  /// Vector of objects
  vector<TestString>? value;

  TestVectorStringObject({
    super.extra,
    super.client_id,
    this.value,
  });

  TestVectorStringObject.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['value'] != null) {
      value = [];
      for (var someValue in map['value']) {
        if (someValue != null) {
          value?.add(TdApiMap.fromMap(someValue) as TestString);
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

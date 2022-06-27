import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/test_string.dart';

class TestVectorStringObject extends TdObject {
  String get tdType => 'testVectorStringObject';

  String? extra;
  int? client_id;
  vector<TestString>? value;

  TestVectorStringObject({
    this.extra,
    this.client_id,
    this.value,
  });

  TestVectorStringObject.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['value']) {
      value = [];
      for (var someValue in map['value']) {
        value?.add(TdApiMap.fromMap(someValue) as TestString);
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

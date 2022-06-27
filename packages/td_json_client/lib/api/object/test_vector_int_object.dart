import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/test_int.dart';

class TestVectorIntObject extends TdObject {
  String get tdType => 'testVectorIntObject';

  String? extra;
  int? client_id;
  vector<TestInt>? value;

  TestVectorIntObject({
    this.extra,
    this.client_id,
    this.value,
  });

  TestVectorIntObject.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['value']) {
      value = [];
      for (var someValue in map['value']) {
        value?.add(TdApiMap.fromMap(someValue) as TestInt);
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

import 'package:td_json_client/api/base.dart';

class TestVectorInt extends TdObject {
  String get tdType => 'testVectorInt';

  string? extra;
  int? client_id;
  vector<int32>? value;

  TestVectorInt({
    this.extra,
    this.client_id,
    this.value,
  });

  TestVectorInt.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['value']) {
      value = [];
      for (var someValue in map['value']) {
        value?.add(someValue);
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

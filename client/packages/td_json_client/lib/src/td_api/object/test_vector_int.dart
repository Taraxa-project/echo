import 'package:td_json_client/src/td_api/td.dart';

/// A simple object containing a vector of numbers; for testing only
class TestVectorInt extends TdObject {
  String get tdType => 'testVectorInt';

  /// Vector of numbers
  vector<int32>? value;

  TestVectorInt({
    super.extra,
    super.client_id,
    this.value,
  });

  TestVectorInt.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['value'] != null) {
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

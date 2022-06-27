import 'package:td_json_client/api/base.dart';


/// A simple object containing a vector of strings; for testing only 
class TestVectorString extends TdObject {
  String get tdType => 'testVectorString';

  String? extra;
  int? client_id;

  /// Vector of strings
  vector<string>? value;

  TestVectorString({
    this.extra,
    this.client_id,
    this.value,
  });

  TestVectorString.fromMap(Map<String, dynamic> map) {
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

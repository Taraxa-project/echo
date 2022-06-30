import 'package:td_json_client/api/base.dart';


/// A simple object containing a number; for testing only 
class TestInt extends TdObject {
  String get tdType => 'testInt';


  /// Number
  int32? value;

  TestInt({
    super.extra,
    super.client_id,
    this.value,
  });

  TestInt.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    value = map['value'];
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

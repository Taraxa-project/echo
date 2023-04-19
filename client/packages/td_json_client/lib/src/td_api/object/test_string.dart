import 'package:td_json_client/src/td_api/td.dart';

/// A simple object containing a string; for testing only
class TestString extends TdObject {
  String get tdType => 'testString';

  /// String
  string? value;

  TestString({
    super.extra,
    super.client_id,
    this.value,
  });

  TestString.fromMap(Map<String, dynamic> map) {
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

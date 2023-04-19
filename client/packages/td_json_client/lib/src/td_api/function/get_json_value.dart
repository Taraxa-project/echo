import 'package:td_json_client/src/td_api/td.dart';

/// Converts a JSON-serialized string to corresponding JsonValue object. Can be called synchronously
class GetJsonValue extends TdFunction {
  String get tdType => 'getJsonValue';
  String get tdReturnType => 'JsonValue';

  /// The JSON-serialized string
  string? json;

  GetJsonValue({
    super.extra,
    super.client_id,
    this.json,
  });

  GetJsonValue.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    json = map['json'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'json': json?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

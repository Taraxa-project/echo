import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/json_value.dart';

/// Converts a JsonValue object to corresponding JSON-serialized string. Can be called synchronously
class GetJsonString extends TdFunction {
  String get tdType => 'getJsonString';
  String get tdReturnType => 'Text';

  /// The JsonValue object
  JsonValue? json_value;

  GetJsonString({
    super.extra,
    super.client_id,
    this.json_value,
  });

  GetJsonString.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['json_value'] != null) {
      json_value = TdApiMap.fromMap(map['json_value']) as JsonValue;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'json_value': json_value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

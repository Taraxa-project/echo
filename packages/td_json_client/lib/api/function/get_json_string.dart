import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/json_value.dart';

class GetJsonString extends TdFunction {
  String get tdType => 'getJsonString';
  String get tdReturnType => 'Text';

  String? extra;
  int? client_id;
  JsonValue? json_value;

  GetJsonString({
    this.extra,
    this.client_id,
    this.json_value,
  });

  GetJsonString.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    json_value = TdApiMap.fromMap(map['json_value']) as JsonValue;
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

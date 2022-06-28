import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/json_value.dart';


/// Represents one member of a JSON object 
class JsonObjectMember extends TdObject {
  String get tdType => 'jsonObjectMember';

  String? extra;
  int? client_id;

  /// Member's key 
  string? key;

  /// Member's value
  JsonValue? value;

  JsonObjectMember({
    this.extra,
    this.client_id,
    this.key,
    this.value,
  });

  JsonObjectMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    key = map['key'];
    value = TdApiMap.fromMap(map['value']) as JsonValue;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'key': key?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';


/// Contains the result of a custom request 
class CustomRequestResult extends TdObject {
  String get tdType => 'customRequestResult';


  /// A JSON-serialized result
  string? result;

  CustomRequestResult({
    super.extra,
    super.client_id,
    this.result,
  });

  CustomRequestResult.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    result = map['result'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'result': result?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

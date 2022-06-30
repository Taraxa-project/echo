import 'package:td_json_client/api/base.dart';


/// Sends a custom request; for bots only 
class SendCustomRequest extends TdFunction {
  String get tdType => 'sendCustomRequest';
  String get tdReturnType => 'CustomRequestResult';


  /// The method name 
  string? method;

  /// JSON-serialized method parameters
  string? parameters;

  SendCustomRequest({
    super.extra,
    super.client_id,
    this.method,
    this.parameters,
  });

  SendCustomRequest.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    method = map['method'];
    parameters = map['parameters'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'method': method?.toMap(skipNulls: skipNulls),
      'parameters': parameters?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

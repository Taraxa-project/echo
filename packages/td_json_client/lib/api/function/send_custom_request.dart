import 'package:td_json_client/api/base.dart';

class SendCustomRequest extends TdFunction {
  String get tdType => 'sendCustomRequest';
  String get tdReturnType => 'CustomRequestResult';

  string? extra;
  int? client_id;
  string? method;
  string? parameters;

  SendCustomRequest({
    this.extra,
    this.client_id,
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
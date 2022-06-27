import 'package:td_json_client/api/base.dart';

class Error extends TdObject {
  String get tdType => 'error';

  String? extra;
  int? client_id;
  int32? code;
  string? message;

  Error({
    this.extra,
    this.client_id,
    this.code,
    this.message,
  });

  Error.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    code = map['code'];
    message = map['message'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'code': code?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

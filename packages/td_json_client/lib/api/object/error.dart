import 'package:td_json_client/api/base.dart';


/// An object of this type can be returned on every function call, in case of an error
class Error extends TdObject {
  String get tdType => 'error';


  /// Error code; subject to future changes. If the error code is 406, the error message must not be processed in any way and must not be displayed to the user
  int32? code;

  /// Error message; subject to future changes
  string? message;

  Error({
    super.extra,
    super.client_id,
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

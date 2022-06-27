import 'package:td_json_client/api/base.dart';

class CreateTemporaryPassword extends TdFunction {
  String get tdType => 'createTemporaryPassword';
  String get tdReturnType => 'TemporaryPasswordState';

  String? extra;
  int? client_id;
  string? password;
  int32? valid_for;

  CreateTemporaryPassword({
    this.extra,
    this.client_id,
    this.password,
    this.valid_for,
  });

  CreateTemporaryPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    password = map['password'];
    valid_for = map['valid_for'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
      'valid_for': valid_for?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

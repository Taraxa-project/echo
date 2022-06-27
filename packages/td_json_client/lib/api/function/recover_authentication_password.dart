import 'package:td_json_client/api/base.dart';

class RecoverAuthenticationPassword extends TdFunction {
  String get tdType => 'recoverAuthenticationPassword';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  string? recovery_code;
  string? new_password;
  string? new_hint;

  RecoverAuthenticationPassword({
    this.extra,
    this.client_id,
    this.recovery_code,
    this.new_password,
    this.new_hint,
  });

  RecoverAuthenticationPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    recovery_code = map['recovery_code'];
    new_password = map['new_password'];
    new_hint = map['new_hint'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'recovery_code': recovery_code?.toMap(skipNulls: skipNulls),
      'new_password': new_password?.toMap(skipNulls: skipNulls),
      'new_hint': new_hint?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
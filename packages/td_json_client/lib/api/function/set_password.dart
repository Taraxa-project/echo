import 'package:td_json_client/api/base.dart';

class SetPassword extends TdFunction {
  String get tdType => 'setPassword';
  String get tdReturnType => 'PasswordState';

  string? extra;
  int? client_id;
  string? old_password;
  string? new_password;
  string? new_hint;
  Bool? set_recovery_email_address;
  string? new_recovery_email_address;

  SetPassword({
    this.extra,
    this.client_id,
    this.old_password,
    this.new_password,
    this.new_hint,
    this.set_recovery_email_address,
    this.new_recovery_email_address,
  });

  SetPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    old_password = map['old_password'];
    new_password = map['new_password'];
    new_hint = map['new_hint'];
    set_recovery_email_address = map['set_recovery_email_address'];
    new_recovery_email_address = map['new_recovery_email_address'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'old_password': old_password?.toMap(skipNulls: skipNulls),
      'new_password': new_password?.toMap(skipNulls: skipNulls),
      'new_hint': new_hint?.toMap(skipNulls: skipNulls),
      'set_recovery_email_address': set_recovery_email_address?.toMap(skipNulls: skipNulls),
      'new_recovery_email_address': new_recovery_email_address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

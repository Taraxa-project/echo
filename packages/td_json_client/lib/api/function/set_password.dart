import 'package:td_json_client/api/base.dart';


/// Changes the password for the current user. If a new recovery email address is specified, then the change will not be applied until the new recovery email address is confirmed
class SetPassword extends TdFunction {
  String get tdType => 'setPassword';
  String get tdReturnType => 'PasswordState';

  String? extra;
  int? client_id;

  /// Previous password of the user 
  string? old_password;

  /// New password of the user; may be empty to remove the password 
  string? new_password;

  /// New password hint; may be empty 
  string? new_hint;

  /// Pass true to change also the recovery email address 
  Bool? set_recovery_email_address;

  /// New recovery email address; may be empty
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

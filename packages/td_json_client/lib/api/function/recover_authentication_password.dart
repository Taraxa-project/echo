import 'package:td_json_client/api/base.dart';


/// Recovers the 2-step verification password with a password recovery code sent to an email address that was previously set up. Works only when the current authorization state is authorizationStateWaitPassword
class RecoverAuthenticationPassword extends TdFunction {
  String get tdType => 'recoverAuthenticationPassword';
  String get tdReturnType => 'Ok';


  /// Recovery code to check 
  string? recovery_code;

  /// New 2-step verification password of the user; may be empty to remove the password 
  string? new_password;

  /// New password hint; may be empty
  string? new_hint;

  RecoverAuthenticationPassword({
    super.extra,
    super.client_id,
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

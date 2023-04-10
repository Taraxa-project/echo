import 'package:td_json_client/src/td_api/td.dart';

/// Changes the 2-step verification recovery email address of the user. If a new recovery email address is specified, then the change will not be applied until the new recovery email address is confirmed.
/// If new_recovery_email_address is the same as the email address that is currently set up, this call succeeds immediately and aborts all other requests waiting for an email confirmation
class SetRecoveryEmailAddress extends TdFunction {
  String get tdType => 'setRecoveryEmailAddress';
  String get tdReturnType => 'PasswordState';

  /// The 2-step verification password of the current user
  string? password;

  /// New recovery email address
  string? new_recovery_email_address;

  SetRecoveryEmailAddress({
    super.extra,
    super.client_id,
    this.password,
    this.new_recovery_email_address,
  });

  SetRecoveryEmailAddress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    password = map['password'];
    new_recovery_email_address = map['new_recovery_email_address'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
      'new_recovery_email_address': new_recovery_email_address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

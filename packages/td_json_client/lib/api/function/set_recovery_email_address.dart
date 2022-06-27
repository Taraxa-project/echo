import 'package:td_json_client/api/base.dart';

class SetRecoveryEmailAddress extends TdFunction {
  String get tdType => 'setRecoveryEmailAddress';
  String get tdReturnType => 'PasswordState';

  string? extra;
  int? client_id;
  string? password;
  string? new_recovery_email_address;

  SetRecoveryEmailAddress({
    this.extra,
    this.client_id,
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

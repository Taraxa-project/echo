import 'package:td_json_client/src/td_api/td.dart';

/// Checks the 2-step verification recovery email address verification code
class CheckRecoveryEmailAddressCode extends TdFunction {
  String get tdType => 'checkRecoveryEmailAddressCode';
  String get tdReturnType => 'PasswordState';

  /// Verification code to check
  string? code;

  CheckRecoveryEmailAddressCode({
    super.extra,
    super.client_id,
    this.code,
  });

  CheckRecoveryEmailAddressCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    code = map['code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'code': code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

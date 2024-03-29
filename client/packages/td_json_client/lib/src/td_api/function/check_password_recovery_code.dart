import 'package:td_json_client/src/td_api/td.dart';

/// Checks whether a 2-step verification password recovery code sent to an email address is valid
class CheckPasswordRecoveryCode extends TdFunction {
  String get tdType => 'checkPasswordRecoveryCode';
  String get tdReturnType => 'Ok';

  /// Recovery code to check
  string? recovery_code;

  CheckPasswordRecoveryCode({
    super.extra,
    super.client_id,
    this.recovery_code,
  });

  CheckPasswordRecoveryCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    recovery_code = map['recovery_code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'recovery_code': recovery_code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

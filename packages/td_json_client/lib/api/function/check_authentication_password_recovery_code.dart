import 'package:td_json_client/api/base.dart';

class CheckAuthenticationPasswordRecoveryCode extends TdFunction {
  String get tdType => 'checkAuthenticationPasswordRecoveryCode';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  string? recovery_code;

  CheckAuthenticationPasswordRecoveryCode({
    this.extra,
    this.client_id,
    this.recovery_code,
  });

  CheckAuthenticationPasswordRecoveryCode.fromMap(Map<String, dynamic> map) {
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

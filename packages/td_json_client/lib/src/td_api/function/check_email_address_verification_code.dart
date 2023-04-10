import 'package:td_json_client/src/td_api/td.dart';

/// Checks the email address verification code for Telegram Passport
class CheckEmailAddressVerificationCode extends TdFunction {
  String get tdType => 'checkEmailAddressVerificationCode';
  String get tdReturnType => 'Ok';

  /// Verification code to check
  string? code;

  CheckEmailAddressVerificationCode({
    super.extra,
    super.client_id,
    this.code,
  });

  CheckEmailAddressVerificationCode.fromMap(Map<String, dynamic> map) {
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

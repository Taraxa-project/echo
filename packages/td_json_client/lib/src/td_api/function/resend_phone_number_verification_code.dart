import 'package:td_json_client/src/td_api/td.dart';

/// Resends the code to verify a phone number to be added to a user's Telegram Passport
class ResendPhoneNumberVerificationCode extends TdFunction {
  String get tdType => 'resendPhoneNumberVerificationCode';
  String get tdReturnType => 'AuthenticationCodeInfo';

  ResendPhoneNumberVerificationCode({
    super.extra,
    super.client_id,
  });

  ResendPhoneNumberVerificationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';

class ResendEmailAddressVerificationCode extends TdFunction {
  String get tdType => 'resendEmailAddressVerificationCode';
  String get tdReturnType => 'EmailAddressAuthenticationCodeInfo';

  String? extra;
  int? client_id;

  ResendEmailAddressVerificationCode({
    this.extra,
    this.client_id,
  });

  ResendEmailAddressVerificationCode.fromMap(Map<String, dynamic> map) {
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

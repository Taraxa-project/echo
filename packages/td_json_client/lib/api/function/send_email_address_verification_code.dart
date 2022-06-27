import 'package:td_json_client/api/base.dart';

class SendEmailAddressVerificationCode extends TdFunction {
  String get tdType => 'sendEmailAddressVerificationCode';
  String get tdReturnType => 'EmailAddressAuthenticationCodeInfo';

  string? extra;
  int? client_id;
  string? email_address;

  SendEmailAddressVerificationCode({
    this.extra,
    this.client_id,
    this.email_address,
  });

  SendEmailAddressVerificationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    email_address = map['email_address'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'email_address': email_address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

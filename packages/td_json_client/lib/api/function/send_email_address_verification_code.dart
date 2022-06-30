import 'package:td_json_client/api/base.dart';


/// Sends a code to verify an email address to be added to a user's Telegram Passport 
class SendEmailAddressVerificationCode extends TdFunction {
  String get tdType => 'sendEmailAddressVerificationCode';
  String get tdReturnType => 'EmailAddressAuthenticationCodeInfo';


  /// Email address
  string? email_address;

  SendEmailAddressVerificationCode({
    super.extra,
    super.client_id,
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

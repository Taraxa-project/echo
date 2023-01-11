import 'package:td_json_client/api/base.dart';


/// Resends the login email address verification code
class ResendLoginEmailAddressCode extends TdFunction {
  String get tdType => 'resendLoginEmailAddressCode';
  String get tdReturnType => 'EmailAddressAuthenticationCodeInfo';


  ResendLoginEmailAddressCode({
    super.extra,
    super.client_id,
  });

  ResendLoginEmailAddressCode.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/src/td_api/td.dart';

/// Resends the authentication code sent to confirm a new phone number for the current user. Works only if the previously received authenticationCodeInfo next_code_type was not null and the server-specified timeout has passed
class ResendChangePhoneNumberCode extends TdFunction {
  String get tdType => 'resendChangePhoneNumberCode';
  String get tdReturnType => 'AuthenticationCodeInfo';

  ResendChangePhoneNumberCode({
    super.extra,
    super.client_id,
  });

  ResendChangePhoneNumberCode.fromMap(Map<String, dynamic> map) {
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

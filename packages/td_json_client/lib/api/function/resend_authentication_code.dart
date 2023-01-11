import 'package:td_json_client/api/base.dart';


/// Resends an authentication code to the user. Works only when the current authorization state is authorizationStateWaitCode, the next_code_type of the result is not null and the server-specified timeout has passed,
/// or when the current authorization state is authorizationStateWaitEmailCode
class ResendAuthenticationCode extends TdFunction {
  String get tdType => 'resendAuthenticationCode';
  String get tdReturnType => 'Ok';


  ResendAuthenticationCode({
    super.extra,
    super.client_id,
  });

  ResendAuthenticationCode.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/api/base.dart';


/// Requests to send a password recovery code to an email address that was previously set up. Works only when the current authorization state is authorizationStateWaitPassword
class RequestAuthenticationPasswordRecovery extends TdFunction {
  String get tdType => 'requestAuthenticationPasswordRecovery';
  String get tdReturnType => 'Ok';


  RequestAuthenticationPasswordRecovery({
    super.extra,
    super.client_id,
  });

  RequestAuthenticationPasswordRecovery.fromMap(Map<String, dynamic> map) {
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

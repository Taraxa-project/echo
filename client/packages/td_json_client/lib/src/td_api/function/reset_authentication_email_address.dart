import 'package:td_json_client/src/td_api/td.dart';

/// Resets the login email address. May return an error with a message "TASK_ALREADY_EXISTS" if reset is still pending.
/// Works only when the current authorization state is authorizationStateWaitEmailCode and authorization_state.can_reset_email_address == true
class ResetAuthenticationEmailAddress extends TdFunction {
  String get tdType => 'resetAuthenticationEmailAddress';
  String get tdReturnType => 'Ok';

  ResetAuthenticationEmailAddress({
    super.extra,
    super.client_id,
  });

  ResetAuthenticationEmailAddress.fromMap(Map<String, dynamic> map) {
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

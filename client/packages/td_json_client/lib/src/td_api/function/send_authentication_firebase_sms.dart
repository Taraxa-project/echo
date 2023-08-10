import 'package:td_json_client/src/td_api/td.dart';

/// Sends Firebase Authentication SMS to the phone number of the user. Works only when the current authorization state is authorizationStateWaitCode and the server returned code of the type authenticationCodeTypeFirebaseAndroid or authenticationCodeTypeFirebaseIos
class SendAuthenticationFirebaseSms extends TdFunction {
  String get tdType => 'sendAuthenticationFirebaseSms';
  String get tdReturnType => 'Ok';

  /// SafetyNet Attestation API token for the Android application, or secret from push notification for the iOS application
  string? token;

  SendAuthenticationFirebaseSms({
    super.extra,
    super.client_id,
    this.token,
  });

  SendAuthenticationFirebaseSms.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    token = map['token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'token': token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Sets the email address of the user and sends an authentication code to the email address. Works only when the current authorization state is authorizationStateWaitEmailAddress
class SetAuthenticationEmailAddress extends TdFunction {
  String get tdType => 'setAuthenticationEmailAddress';
  String get tdReturnType => 'Ok';

  /// The email address of the user
  string? email_address;

  SetAuthenticationEmailAddress({
    super.extra,
    super.client_id,
    this.email_address,
  });

  SetAuthenticationEmailAddress.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/src/td_api/td.dart';

/// Returns already available Telegram Passport elements suitable for completing a Telegram Passport authorization form. Result can be received only once for each authorization form
class GetPassportAuthorizationFormAvailableElements extends TdFunction {
  String get tdType => 'getPassportAuthorizationFormAvailableElements';
  String get tdReturnType => 'PassportElementsWithErrors';

  /// Authorization form identifier
  int32? authorization_form_id;

  /// The 2-step verification password of the current user
  string? password;

  GetPassportAuthorizationFormAvailableElements({
    super.extra,
    super.client_id,
    this.authorization_form_id,
    this.password,
  });

  GetPassportAuthorizationFormAvailableElements.fromMap(
      Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    authorization_form_id = map['authorization_form_id'];
    password = map['password'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'authorization_form_id':
          authorization_form_id?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';


/// Checks the 2-step verification password for correctness. Works only when the current authorization state is authorizationStateWaitPassword 
class CheckAuthenticationPassword extends TdFunction {
  String get tdType => 'checkAuthenticationPassword';
  String get tdReturnType => 'Ok';


  /// The 2-step verification password to check
  string? password;

  CheckAuthenticationPassword({
    super.extra,
    super.client_id,
    this.password,
  });

  CheckAuthenticationPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    password = map['password'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Checks the authentication code. Works only when the current authorization state is authorizationStateWaitCode
class CheckAuthenticationCode extends TdFunction {
  String get tdType => 'checkAuthenticationCode';
  String get tdReturnType => 'Ok';

  /// Authentication code to check
  string? code;

  CheckAuthenticationCode({
    super.extra,
    super.client_id,
    this.code,
  });

  CheckAuthenticationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    code = map['code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'code': code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

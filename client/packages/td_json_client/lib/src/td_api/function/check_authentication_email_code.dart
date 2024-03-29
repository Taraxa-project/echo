import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/email_address_authentication.dart';

/// Checks the authentication of a email address. Works only when the current authorization state is authorizationStateWaitEmailCode
class CheckAuthenticationEmailCode extends TdFunction {
  String get tdType => 'checkAuthenticationEmailCode';
  String get tdReturnType => 'Ok';

  /// Email address authentication to check
  EmailAddressAuthentication? code;

  CheckAuthenticationEmailCode({
    super.extra,
    super.client_id,
    this.code,
  });

  CheckAuthenticationEmailCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['code'] != null) {
      code = TdApiMap.fromMap(map['code']) as EmailAddressAuthentication;
    }
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

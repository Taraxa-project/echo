import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/email_address_authentication.dart';


/// Checks the login email address authentication 
class CheckLoginEmailAddressCode extends TdFunction {
  String get tdType => 'checkLoginEmailAddressCode';
  String get tdReturnType => 'Ok';


  /// Email address authentication to check
  EmailAddressAuthentication? code;

  CheckLoginEmailAddressCode({
    super.extra,
    super.client_id,
    this.code,
  });

  CheckLoginEmailAddressCode.fromMap(Map<String, dynamic> map) {
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

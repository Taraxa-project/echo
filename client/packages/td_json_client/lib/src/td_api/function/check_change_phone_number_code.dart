import 'package:td_json_client/src/td_api/td.dart';

/// Checks the authentication code sent to confirm a new phone number of the user
class CheckChangePhoneNumberCode extends TdFunction {
  String get tdType => 'checkChangePhoneNumberCode';
  String get tdReturnType => 'Ok';

  /// Authentication code to check
  string? code;

  CheckChangePhoneNumberCode({
    super.extra,
    super.client_id,
    this.code,
  });

  CheckChangePhoneNumberCode.fromMap(Map<String, dynamic> map) {
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

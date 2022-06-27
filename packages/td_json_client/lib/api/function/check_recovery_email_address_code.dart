import 'package:td_json_client/api/base.dart';

class CheckRecoveryEmailAddressCode extends TdFunction {
  String get tdType => 'checkRecoveryEmailAddressCode';
  String get tdReturnType => 'PasswordState';

  String? extra;
  int? client_id;
  string? code;

  CheckRecoveryEmailAddressCode({
    this.extra,
    this.client_id,
    this.code,
  });

  CheckRecoveryEmailAddressCode.fromMap(Map<String, dynamic> map) {
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

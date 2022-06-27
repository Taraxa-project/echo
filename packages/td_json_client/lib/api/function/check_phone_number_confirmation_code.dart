import 'package:td_json_client/api/base.dart';

class CheckPhoneNumberConfirmationCode extends TdFunction {
  String get tdType => 'checkPhoneNumberConfirmationCode';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  string? code;

  CheckPhoneNumberConfirmationCode({
    this.extra,
    this.client_id,
    this.code,
  });

  CheckPhoneNumberConfirmationCode.fromMap(Map<String, dynamic> map) {
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

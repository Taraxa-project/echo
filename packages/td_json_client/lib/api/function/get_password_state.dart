import 'package:td_json_client/api/base.dart';

class GetPasswordState extends TdFunction {
  String get tdType => 'getPasswordState';
  String get tdReturnType => 'PasswordState';

  String? extra;
  int? client_id;

  GetPasswordState({
    this.extra,
    this.client_id,
  });

  GetPasswordState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

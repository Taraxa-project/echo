import 'package:td_json_client/api/base.dart';

class ResetPassword extends TdFunction {
  String get tdType => 'resetPassword';
  String get tdReturnType => 'ResetPasswordResult';

  string? extra;
  int? client_id;

  ResetPassword({
    this.extra,
    this.client_id,
  });

  ResetPassword.fromMap(Map<String, dynamic> map) {
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

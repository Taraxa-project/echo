import 'package:td_json_client/src/td_api/td.dart';

/// Returns all available Telegram Passport elements
class GetAllPassportElements extends TdFunction {
  String get tdType => 'getAllPassportElements';
  String get tdReturnType => 'PassportElements';

  /// The 2-step verification password of the current user
  string? password;

  GetAllPassportElements({
    super.extra,
    super.client_id,
    this.password,
  });

  GetAllPassportElements.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/api/base.dart';

class GetPassportAuthorizationFormAvailableElements extends TdFunction {
  String get tdType => 'getPassportAuthorizationFormAvailableElements';
  String get tdReturnType => 'PassportElementsWithErrors';

  string? extra;
  int? client_id;
  int32? autorization_form_id;
  string? password;

  GetPassportAuthorizationFormAvailableElements({
    this.extra,
    this.client_id,
    this.autorization_form_id,
    this.password,
  });

  GetPassportAuthorizationFormAvailableElements.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    autorization_form_id = map['autorization_form_id'];
    password = map['password'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'autorization_form_id': autorization_form_id?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

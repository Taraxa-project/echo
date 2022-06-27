import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';

class GetPassportElement extends TdFunction {
  String get tdType => 'getPassportElement';
  String get tdReturnType => 'PassportElement';

  string? extra;
  int? client_id;
  PassportElementType? type;
  string? password;

  GetPassportElement({
    this.extra,
    this.client_id,
    this.type,
    this.password,
  });

  GetPassportElement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    type = TdApiMap.fromMap(map['type']) as PassportElementType;
    password = map['password'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

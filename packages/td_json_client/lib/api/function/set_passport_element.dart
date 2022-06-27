import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_passport_element.dart';

class SetPassportElement extends TdFunction {
  String get tdType => 'setPassportElement';
  String get tdReturnType => 'PassportElement';

  string? extra;
  int? client_id;
  InputPassportElement? element;
  string? password;

  SetPassportElement({
    this.extra,
    this.client_id,
    this.element,
    this.password,
  });

  SetPassportElement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    element = TdApiMap.fromMap(map['element']) as InputPassportElement;
    password = map['password'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'element': element?.toMap(skipNulls: skipNulls),
      'password': password?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

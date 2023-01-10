import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_passport_element.dart';


/// Adds an element to the user's Telegram Passport. May return an error with a message "PHONE_VERIFICATION_NEEDED" or "EMAIL_VERIFICATION_NEEDED" if the chosen phone number or the chosen email address must be verified first 
class SetPassportElement extends TdFunction {
  String get tdType => 'setPassportElement';
  String get tdReturnType => 'PassportElement';


  /// Input Telegram Passport element 
  InputPassportElement? element;

  /// The 2-step verification password of the current user
  string? password;

  SetPassportElement({
    super.extra,
    super.client_id,
    this.element,
    this.password,
  });

  SetPassportElement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['element'] != null) {
      element = TdApiMap.fromMap(map['element']) as InputPassportElement;
    }
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

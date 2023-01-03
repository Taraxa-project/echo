import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';


/// Returns one of the available Telegram Passport elements 
class GetPassportElement extends TdFunction {
  String get tdType => 'getPassportElement';
  String get tdReturnType => 'PassportElement';


  /// Telegram Passport element type 
  PassportElementType? type;

  /// The 2-step verification password of the current user
  string? password;

  GetPassportElement({
    super.extra,
    super.client_id,
    this.type,
    this.password,
  });

  GetPassportElement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as PassportElementType;
    }
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

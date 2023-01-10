import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';


/// Sends a Telegram Passport authorization form, effectively sharing data with the service. This method must be called after getPassportAuthorizationFormAvailableElements if some previously available elements are going to be reused
class SendPassportAuthorizationForm extends TdFunction {
  String get tdType => 'sendPassportAuthorizationForm';
  String get tdReturnType => 'Ok';


  /// Authorization form identifier 
  int32? autorization_form_id;

  /// Types of Telegram Passport elements chosen by user to complete the authorization form
  vector<PassportElementType>? types;

  SendPassportAuthorizationForm({
    super.extra,
    super.client_id,
    this.autorization_form_id,
    this.types,
  });

  SendPassportAuthorizationForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    autorization_form_id = map['autorization_form_id'];
    if (map['types'] != null) {
      types = [];
      for (var someValue in map['types']) {
        if (someValue != null) {
          types?.add(TdApiMap.fromMap(someValue) as PassportElementType);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'autorization_form_id': autorization_form_id?.toMap(skipNulls: skipNulls),
      'types': types?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

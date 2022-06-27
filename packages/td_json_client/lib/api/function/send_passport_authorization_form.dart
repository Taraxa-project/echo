import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';

class SendPassportAuthorizationForm extends TdFunction {
  String get tdType => 'sendPassportAuthorizationForm';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? autorization_form_id;
  vector<PassportElementType>? types;

  SendPassportAuthorizationForm({
    this.extra,
    this.client_id,
    this.autorization_form_id,
    this.types,
  });

  SendPassportAuthorizationForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    autorization_form_id = map['autorization_form_id'];
    if (map['types']) {
      types = [];
      for (var someValue in map['types']) {
        types?.add(TdApiMap.fromMap(someValue) as PassportElementType);
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

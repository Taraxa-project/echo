import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_passport_element_error.dart';

class SetPassportElementErrors extends TdFunction {
  String get tdType => 'setPassportElementErrors';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int53? user_id;
  vector<InputPassportElementError>? errors;

  SetPassportElementErrors({
    this.extra,
    this.client_id,
    this.user_id,
    this.errors,
  });

  SetPassportElementErrors.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    if (map['errors']) {
      errors = [];
      for (var someValue in map['errors']) {
        errors?.add(TdApiMap.fromMap(someValue) as InputPassportElementError);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'errors': errors?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_passport_element_error.dart';

/// Informs the user that some of the elements in their Telegram Passport contain errors; for bots only. The user will not be able to resend the elements, until the errors are fixed
class SetPassportElementErrors extends TdFunction {
  String get tdType => 'setPassportElementErrors';
  String get tdReturnType => 'Ok';

  /// User identifier
  int53? user_id;

  /// The errors
  vector<InputPassportElementError>? errors;

  SetPassportElementErrors({
    super.extra,
    super.client_id,
    this.user_id,
    this.errors,
  });

  SetPassportElementErrors.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    if (map['errors'] != null) {
      errors = [];
      for (var someValue in map['errors']) {
        if (someValue != null) {
          errors?.add(TdApiMap.fromMap(someValue) as InputPassportElementError);
        }
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

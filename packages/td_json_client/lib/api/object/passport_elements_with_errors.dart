import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element.dart';
import 'package:td_json_client/api/object/passport_element_error.dart';


/// Contains information about a Telegram Passport elements and corresponding errors 
class PassportElementsWithErrors extends TdObject {
  String get tdType => 'passportElementsWithErrors';

  String? extra;
  int? client_id;

  /// Telegram Passport elements 
  vector<PassportElement>? elements;

  /// Errors in the elements that are already available
  vector<PassportElementError>? errors;

  PassportElementsWithErrors({
    this.extra,
    this.client_id,
    this.elements,
    this.errors,
  });

  PassportElementsWithErrors.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['elements']) {
      elements = [];
      for (var someValue in map['elements']) {
        elements?.add(TdApiMap.fromMap(someValue) as PassportElement);
      }
    }
    if (map['errors']) {
      errors = [];
      for (var someValue in map['errors']) {
        errors?.add(TdApiMap.fromMap(someValue) as PassportElementError);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'elements': elements?.toMap(skipNulls: skipNulls),
      'errors': errors?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

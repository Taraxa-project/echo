import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';


/// Contains information about a Telegram Passport element that was requested by a service 
class PassportSuitableElement extends TdObject {
  String get tdType => 'passportSuitableElement';

  String? extra;
  int? client_id;

  /// Type of the element 
  PassportElementType? type;

  /// True, if a selfie is required with the identity document
  Bool? is_selfie_required;

  /// True, if a certified English translation is required with the document 
  Bool? is_translation_required;

  /// True, if personal details must include the user's name in the language of their country of residence
  Bool? is_native_name_required;

  PassportSuitableElement({
    this.extra,
    this.client_id,
    this.type,
    this.is_selfie_required,
    this.is_translation_required,
    this.is_native_name_required,
  });

  PassportSuitableElement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as PassportElementType;
    }
    is_selfie_required = map['is_selfie_required'];
    is_translation_required = map['is_translation_required'];
    is_native_name_required = map['is_native_name_required'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'is_selfie_required': is_selfie_required?.toMap(skipNulls: skipNulls),
      'is_translation_required': is_translation_required?.toMap(skipNulls: skipNulls),
      'is_native_name_required': is_native_name_required?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

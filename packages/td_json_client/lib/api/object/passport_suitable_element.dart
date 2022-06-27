import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';

class PassportSuitableElement extends TdObject {
  String get tdType => 'passportSuitableElement';

  string? extra;
  int? client_id;
  PassportElementType? type;
  Bool? is_selfie_required;
  Bool? is_translation_required;
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
    type = TdApiMap.fromMap(map['type']) as PassportElementType;
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

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/language_pack_string_value.dart';


/// Represents one language pack string 
class LanguagePackString extends TdObject {
  String get tdType => 'languagePackString';

  String? extra;
  int? client_id;

  /// String key 
  string? key;

  /// String value; pass null if the string needs to be taken from the built-in English language pack
  LanguagePackStringValue? value;

  LanguagePackString({
    this.extra,
    this.client_id,
    this.key,
    this.value,
  });

  LanguagePackString.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    key = map['key'];
    value = TdApiMap.fromMap(map['value']) as LanguagePackStringValue;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'key': key?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

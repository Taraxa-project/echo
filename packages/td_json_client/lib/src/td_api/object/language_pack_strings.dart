import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/language_pack_string.dart';

/// Contains a list of language pack strings
class LanguagePackStrings extends TdObject {
  String get tdType => 'languagePackStrings';

  /// A list of language pack strings
  vector<LanguagePackString>? strings;

  LanguagePackStrings({
    super.extra,
    super.client_id,
    this.strings,
  });

  LanguagePackStrings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['strings'] != null) {
      strings = [];
      for (var someValue in map['strings']) {
        if (someValue != null) {
          strings?.add(TdApiMap.fromMap(someValue) as LanguagePackString);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'strings': strings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

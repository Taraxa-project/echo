import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/language_pack_string.dart';

class LanguagePackStrings extends TdObject {
  String get tdType => 'languagePackStrings';

  string? extra;
  int? client_id;
  vector<LanguagePackString>? strings;

  LanguagePackStrings({
    this.extra,
    this.client_id,
    this.strings,
  });

  LanguagePackStrings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['strings']) {
      strings = [];
      for (var someValue in map['strings']) {
        strings?.add(TdApiMap.fromMap(someValue) as LanguagePackString);
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

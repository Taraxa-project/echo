import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/language_pack_info.dart';
import 'package:td_json_client/api/object/language_pack_string.dart';


/// Adds or changes a custom local language pack to the current localization target 
class SetCustomLanguagePack extends TdFunction {
  String get tdType => 'setCustomLanguagePack';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Information about the language pack. Language pack ID must start with 'X', consist only of English letters, digits and hyphens, and must not exceed 64 characters. Can be called before authorization 
  LanguagePackInfo? info;

  /// Strings of the new language pack
  vector<LanguagePackString>? strings;

  SetCustomLanguagePack({
    this.extra,
    this.client_id,
    this.info,
    this.strings,
  });

  SetCustomLanguagePack.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    info = TdApiMap.fromMap(map['info']) as LanguagePackInfo;
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
      'info': info?.toMap(skipNulls: skipNulls),
      'strings': strings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

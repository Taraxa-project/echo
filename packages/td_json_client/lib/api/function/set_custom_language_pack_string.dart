import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/language_pack_string.dart';


/// Adds, edits or deletes a string in a custom local language pack. Can be called before authorization 
class SetCustomLanguagePackString extends TdFunction {
  String get tdType => 'setCustomLanguagePackString';
  String get tdReturnType => 'Ok';


  /// Identifier of a previously added custom local language pack in the current localization target 
  string? language_pack_id;

  /// New language pack string
  LanguagePackString? new_string;

  SetCustomLanguagePackString({
    super.extra,
    super.client_id,
    this.language_pack_id,
    this.new_string,
  });

  SetCustomLanguagePackString.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language_pack_id = map['language_pack_id'];
    if (map['new_string'] != null) {
      new_string = TdApiMap.fromMap(map['new_string']) as LanguagePackString;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language_pack_id': language_pack_id?.toMap(skipNulls: skipNulls),
      'new_string': new_string?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

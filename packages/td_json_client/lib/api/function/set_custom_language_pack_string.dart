import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/language_pack_string.dart';

class SetCustomLanguagePackString extends TdFunction {
  String get tdType => 'setCustomLanguagePackString';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  string? language_pack_id;
  LanguagePackString? new_string;

  SetCustomLanguagePackString({
    this.extra,
    this.client_id,
    this.language_pack_id,
    this.new_string,
  });

  SetCustomLanguagePackString.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language_pack_id = map['language_pack_id'];
    new_string = TdApiMap.fromMap(map['new_string']) as LanguagePackString;
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

import 'package:td_json_client/api/base.dart';


/// Adds a custom server language pack to the list of installed language packs in current localization target. Can be called before authorization 
class AddCustomServerLanguagePack extends TdFunction {
  String get tdType => 'addCustomServerLanguagePack';
  String get tdReturnType => 'Ok';


  /// Identifier of a language pack to be added; may be different from a name that is used in an "https://t.me/setlanguage/" link
  string? language_pack_id;

  AddCustomServerLanguagePack({
    super.extra,
    super.client_id,
    this.language_pack_id,
  });

  AddCustomServerLanguagePack.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language_pack_id = map['language_pack_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language_pack_id': language_pack_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

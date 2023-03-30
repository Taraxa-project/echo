import 'package:td_json_client/src/td_api/td.dart';

/// Returns strings from a language pack in the current localization target by their keys. Can be called before authorization
class GetLanguagePackStrings extends TdFunction {
  String get tdType => 'getLanguagePackStrings';
  String get tdReturnType => 'LanguagePackStrings';

  /// Language pack identifier of the strings to be returned
  string? language_pack_id;

  /// Language pack keys of the strings to be returned; leave empty to request all available strings
  vector<string>? keys;

  GetLanguagePackStrings({
    super.extra,
    super.client_id,
    this.language_pack_id,
    this.keys,
  });

  GetLanguagePackStrings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language_pack_id = map['language_pack_id'];
    if (map['keys'] != null) {
      keys = [];
      for (var someValue in map['keys']) {
        keys?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language_pack_id': language_pack_id?.toMap(skipNulls: skipNulls),
      'keys': keys?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

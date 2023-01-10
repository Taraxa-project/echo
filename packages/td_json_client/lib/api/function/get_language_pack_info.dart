import 'package:td_json_client/api/base.dart';


/// Returns information about a language pack. Returned language pack identifier may be different from a provided one. Can be called before authorization 
class GetLanguagePackInfo extends TdFunction {
  String get tdType => 'getLanguagePackInfo';
  String get tdReturnType => 'LanguagePackInfo';


  /// Language pack identifier
  string? language_pack_id;

  GetLanguagePackInfo({
    super.extra,
    super.client_id,
    this.language_pack_id,
  });

  GetLanguagePackInfo.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/api/base.dart';


/// Returns a string stored in the local database from the specified localization target and language pack by its key. Returns a 404 error if the string is not found. Can be called synchronously
class GetLanguagePackString extends TdFunction {
  String get tdType => 'getLanguagePackString';
  String get tdReturnType => 'LanguagePackStringValue';


  /// Path to the language pack database in which strings are stored
  string? language_pack_database_path;

  /// Localization target to which the language pack belongs
  string? localization_target;

  /// Language pack identifier
  string? language_pack_id;

  /// Language pack key of the string to be returned
  string? key;

  GetLanguagePackString({
    super.extra,
    super.client_id,
    this.language_pack_database_path,
    this.localization_target,
    this.language_pack_id,
    this.key,
  });

  GetLanguagePackString.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language_pack_database_path = map['language_pack_database_path'];
    localization_target = map['localization_target'];
    language_pack_id = map['language_pack_id'];
    key = map['key'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language_pack_database_path': language_pack_database_path?.toMap(skipNulls: skipNulls),
      'localization_target': localization_target?.toMap(skipNulls: skipNulls),
      'language_pack_id': language_pack_id?.toMap(skipNulls: skipNulls),
      'key': key?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

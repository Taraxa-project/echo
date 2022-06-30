import 'package:td_json_client/api/base.dart';


/// Fetches the latest versions of all strings from a language pack in the current localization target from the server. This method doesn't need to be called explicitly for the current used/base language packs. Can be called before authorization 
class SynchronizeLanguagePack extends TdFunction {
  String get tdType => 'synchronizeLanguagePack';
  String get tdReturnType => 'Ok';


  /// Language pack identifier
  string? language_pack_id;

  SynchronizeLanguagePack({
    super.extra,
    super.client_id,
    this.language_pack_id,
  });

  SynchronizeLanguagePack.fromMap(Map<String, dynamic> map) {
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

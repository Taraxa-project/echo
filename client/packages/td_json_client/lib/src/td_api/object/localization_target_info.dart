import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/language_pack_info.dart';

/// Contains information about the current localization target
class LocalizationTargetInfo extends TdObject {
  String get tdType => 'localizationTargetInfo';

  /// List of available language packs for this application
  vector<LanguagePackInfo>? language_packs;

  LocalizationTargetInfo({
    super.extra,
    super.client_id,
    this.language_packs,
  });

  LocalizationTargetInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['language_packs'] != null) {
      language_packs = [];
      for (var someValue in map['language_packs']) {
        if (someValue != null) {
          language_packs?.add(TdApiMap.fromMap(someValue) as LanguagePackInfo);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language_packs': language_packs?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

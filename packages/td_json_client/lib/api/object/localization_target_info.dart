import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/language_pack_info.dart';

class LocalizationTargetInfo extends TdObject {
  String get tdType => 'localizationTargetInfo';

  string? extra;
  int? client_id;
  vector<LanguagePackInfo>? language_packs;

  LocalizationTargetInfo({
    this.extra,
    this.client_id,
    this.language_packs,
  });

  LocalizationTargetInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['language_packs']) {
      language_packs = [];
      for (var someValue in map['language_packs']) {
        language_packs?.add(TdApiMap.fromMap(someValue) as LanguagePackInfo);
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

import 'package:td_json_client/api/base.dart';

class LanguagePackInfo extends TdObject {
  String get tdType => 'languagePackInfo';

  string? extra;
  int? client_id;
  string? id;
  string? base_language_pack_id;
  string? name;
  string? native_name;
  string? plural_code;
  Bool? is_official;
  Bool? is_rtl;
  Bool? is_beta;
  Bool? is_installed;
  int32? total_string_count;
  int32? translated_string_count;
  int32? local_string_count;
  string? translation_url;

  LanguagePackInfo({
    this.extra,
    this.client_id,
    this.id,
    this.base_language_pack_id,
    this.name,
    this.native_name,
    this.plural_code,
    this.is_official,
    this.is_rtl,
    this.is_beta,
    this.is_installed,
    this.total_string_count,
    this.translated_string_count,
    this.local_string_count,
    this.translation_url,
  });

  LanguagePackInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    base_language_pack_id = map['base_language_pack_id'];
    name = map['name'];
    native_name = map['native_name'];
    plural_code = map['plural_code'];
    is_official = map['is_official'];
    is_rtl = map['is_rtl'];
    is_beta = map['is_beta'];
    is_installed = map['is_installed'];
    total_string_count = map['total_string_count'];
    translated_string_count = map['translated_string_count'];
    local_string_count = map['local_string_count'];
    translation_url = map['translation_url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'base_language_pack_id': base_language_pack_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'native_name': native_name?.toMap(skipNulls: skipNulls),
      'plural_code': plural_code?.toMap(skipNulls: skipNulls),
      'is_official': is_official?.toMap(skipNulls: skipNulls),
      'is_rtl': is_rtl?.toMap(skipNulls: skipNulls),
      'is_beta': is_beta?.toMap(skipNulls: skipNulls),
      'is_installed': is_installed?.toMap(skipNulls: skipNulls),
      'total_string_count': total_string_count?.toMap(skipNulls: skipNulls),
      'translated_string_count': translated_string_count?.toMap(skipNulls: skipNulls),
      'local_string_count': local_string_count?.toMap(skipNulls: skipNulls),
      'translation_url': translation_url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';

class CountryInfo extends TdObject {
  String get tdType => 'countryInfo';

  String? extra;
  int? client_id;
  string? country_code;
  string? name;
  string? english_name;
  Bool? is_hidden;
  vector<string>? calling_codes;

  CountryInfo({
    this.extra,
    this.client_id,
    this.country_code,
    this.name,
    this.english_name,
    this.is_hidden,
    this.calling_codes,
  });

  CountryInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    country_code = map['country_code'];
    name = map['name'];
    english_name = map['english_name'];
    is_hidden = map['is_hidden'];
    if (map['calling_codes']) {
      calling_codes = [];
      for (var someValue in map['calling_codes']) {
        calling_codes?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'country_code': country_code?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'english_name': english_name?.toMap(skipNulls: skipNulls),
      'is_hidden': is_hidden?.toMap(skipNulls: skipNulls),
      'calling_codes': calling_codes?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about a country
class CountryInfo extends TdObject {
  String get tdType => 'countryInfo';

  /// A two-letter ISO 3166-1 alpha-2 country code
  string? country_code;

  /// Native name of the country
  string? name;

  /// English name of the country
  string? english_name;

  /// True, if the country must be hidden from the list of all countries
  Bool? is_hidden;

  /// List of country calling codes
  vector<string>? calling_codes;

  CountryInfo({
    super.extra,
    super.client_id,
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
    if (map['calling_codes'] != null) {
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

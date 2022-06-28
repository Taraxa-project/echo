import 'package:td_json_client/api/base.dart';


/// Returns an IETF language tag of the language preferred in the country, which must be used to fill native fields in Telegram Passport personal details. Returns a 404 error if unknown 
class GetPreferredCountryLanguage extends TdFunction {
  String get tdType => 'getPreferredCountryLanguage';
  String get tdReturnType => 'Text';

  String? extra;
  int? client_id;

  /// A two-letter ISO 3166-1 alpha-2 country code
  string? country_code;

  GetPreferredCountryLanguage({
    this.extra,
    this.client_id,
    this.country_code,
  });

  GetPreferredCountryLanguage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    country_code = map['country_code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'country_code': country_code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

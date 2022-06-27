import 'package:td_json_client/api/base.dart';

class GetPreferredCountryLanguage extends TdFunction {
  String get tdType => 'getPreferredCountryLanguage';
  String get tdReturnType => 'Text';

  string? extra;
  int? client_id;
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

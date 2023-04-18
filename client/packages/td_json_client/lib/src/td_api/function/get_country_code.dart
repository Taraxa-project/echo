import 'package:td_json_client/src/td_api/td.dart';

/// Uses the current IP address to find the current country. Returns two-letter ISO 3166-1 alpha-2 country code. Can be called before authorization
class GetCountryCode extends TdFunction {
  String get tdType => 'getCountryCode';
  String get tdReturnType => 'Text';

  GetCountryCode({
    super.extra,
    super.client_id,
  });

  GetCountryCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

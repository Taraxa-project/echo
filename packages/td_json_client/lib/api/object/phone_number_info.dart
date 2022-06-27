import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/country_info.dart';

class PhoneNumberInfo extends TdObject {
  String get tdType => 'phoneNumberInfo';

  String? extra;
  int? client_id;
  CountryInfo? country;
  string? country_calling_code;
  string? formatted_phone_number;

  PhoneNumberInfo({
    this.extra,
    this.client_id,
    this.country,
    this.country_calling_code,
    this.formatted_phone_number,
  });

  PhoneNumberInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    country = TdApiMap.fromMap(map['country']) as CountryInfo;
    country_calling_code = map['country_calling_code'];
    formatted_phone_number = map['formatted_phone_number'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'country': country?.toMap(skipNulls: skipNulls),
      'country_calling_code': country_calling_code?.toMap(skipNulls: skipNulls),
      'formatted_phone_number': formatted_phone_number?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

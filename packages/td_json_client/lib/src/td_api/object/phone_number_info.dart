import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/country_info.dart';

/// Contains information about a phone number
class PhoneNumberInfo extends TdObject {
  String get tdType => 'phoneNumberInfo';

  /// Information about the country to which the phone number belongs; may be null
  CountryInfo? country;

  /// The part of the phone number denoting country calling code or its part
  string? country_calling_code;

  /// The phone number without country calling code formatted accordingly to local rules. Expected digits are returned as '-', but even more digits might be entered by the user
  string? formatted_phone_number;

  /// True, if the phone number was bought on Fragment and isn't tied to a SIM card
  Bool? is_anonymous;

  PhoneNumberInfo({
    super.extra,
    super.client_id,
    this.country,
    this.country_calling_code,
    this.formatted_phone_number,
    this.is_anonymous,
  });

  PhoneNumberInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['country'] != null) {
      country = TdApiMap.fromMap(map['country']) as CountryInfo;
    }
    country_calling_code = map['country_calling_code'];
    formatted_phone_number = map['formatted_phone_number'];
    is_anonymous = map['is_anonymous'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'country': country?.toMap(skipNulls: skipNulls),
      'country_calling_code': country_calling_code?.toMap(skipNulls: skipNulls),
      'formatted_phone_number':
          formatted_phone_number?.toMap(skipNulls: skipNulls),
      'is_anonymous': is_anonymous?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

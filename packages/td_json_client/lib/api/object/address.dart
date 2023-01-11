import 'package:td_json_client/api/base.dart';


/// Describes an address
class Address extends TdObject {
  String get tdType => 'address';


  /// A two-letter ISO 3166-1 alpha-2 country code
  string? country_code;

  /// State, if applicable
  string? state;

  /// City
  string? city;

  /// First line of the address
  string? street_line1;

  /// Second line of the address
  string? street_line2;

  /// Address postal code
  string? postal_code;

  Address({
    super.extra,
    super.client_id,
    this.country_code,
    this.state,
    this.city,
    this.street_line1,
    this.street_line2,
    this.postal_code,
  });

  Address.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    country_code = map['country_code'];
    state = map['state'];
    city = map['city'];
    street_line1 = map['street_line1'];
    street_line2 = map['street_line2'];
    postal_code = map['postal_code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'country_code': country_code?.toMap(skipNulls: skipNulls),
      'state': state?.toMap(skipNulls: skipNulls),
      'city': city?.toMap(skipNulls: skipNulls),
      'street_line1': street_line1?.toMap(skipNulls: skipNulls),
      'street_line2': street_line2?.toMap(skipNulls: skipNulls),
      'postal_code': postal_code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

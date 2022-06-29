import 'package:td_json_client/api/base.dart';


/// Returns information about a phone number by its prefix synchronously. getCountries must be called at least once after changing localization to the specified language if properly localized country information is expected. Can be called synchronously
class GetPhoneNumberInfoSync extends TdFunction {
  String get tdType => 'getPhoneNumberInfoSync';
  String get tdReturnType => 'PhoneNumberInfo';

  String? extra;
  int? client_id;

  /// A two-letter ISO 639-1 country code for country information localization 
  string? language_code;

  /// The phone number prefix
  string? phone_number_prefix;

  GetPhoneNumberInfoSync({
    this.extra,
    this.client_id,
    this.language_code,
    this.phone_number_prefix,
  });

  GetPhoneNumberInfoSync.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language_code = map['language_code'];
    phone_number_prefix = map['phone_number_prefix'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
      'phone_number_prefix': phone_number_prefix?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';


/// Returns information about a phone number by its prefix. Can be called before authorization 
class GetPhoneNumberInfo extends TdFunction {
  String get tdType => 'getPhoneNumberInfo';
  String get tdReturnType => 'PhoneNumberInfo';

  String? extra;
  int? client_id;

  /// The phone number prefix
  string? phone_number_prefix;

  GetPhoneNumberInfo({
    this.extra,
    this.client_id,
    this.phone_number_prefix,
  });

  GetPhoneNumberInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number_prefix = map['phone_number_prefix'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'phone_number_prefix': phone_number_prefix?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Information about the email address authentication code that was sent
class EmailAddressAuthenticationCodeInfo extends TdObject {
  String get tdType => 'emailAddressAuthenticationCodeInfo';

  /// Pattern of the email address to which an authentication code was sent
  string? email_address_pattern;

  /// Length of the code; 0 if unknown
  int32? length;

  EmailAddressAuthenticationCodeInfo({
    super.extra,
    super.client_id,
    this.email_address_pattern,
    this.length,
  });

  EmailAddressAuthenticationCodeInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    email_address_pattern = map['email_address_pattern'];
    length = map['length'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'email_address_pattern':
          email_address_pattern?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

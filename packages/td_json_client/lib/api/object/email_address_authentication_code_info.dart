import 'package:td_json_client/api/base.dart';

class EmailAddressAuthenticationCodeInfo extends TdObject {
  String get tdType => 'emailAddressAuthenticationCodeInfo';

  string? extra;
  int? client_id;
  string? email_address_pattern;
  int32? length;

  EmailAddressAuthenticationCodeInfo({
    this.extra,
    this.client_id,
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
      'email_address_pattern': email_address_pattern?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

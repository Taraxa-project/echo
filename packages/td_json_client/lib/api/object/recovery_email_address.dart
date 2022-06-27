import 'package:td_json_client/api/base.dart';

class RecoveryEmailAddress extends TdObject {
  String get tdType => 'recoveryEmailAddress';

  string? extra;
  int? client_id;
  string? recovery_email_address;

  RecoveryEmailAddress({
    this.extra,
    this.client_id,
    this.recovery_email_address,
  });

  RecoveryEmailAddress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    recovery_email_address = map['recovery_email_address'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'recovery_email_address': recovery_email_address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

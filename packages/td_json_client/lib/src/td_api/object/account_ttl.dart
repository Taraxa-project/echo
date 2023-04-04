import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about the period of inactivity after which the current user's account will automatically be deleted
class AccountTtl extends TdObject {
  String get tdType => 'accountTtl';

  /// Number of days of inactivity before the account will be flagged for deletion; 30-366 days
  int32? days;

  AccountTtl({
    super.extra,
    super.client_id,
    this.days,
  });

  AccountTtl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    days = map['days'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'days': days?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

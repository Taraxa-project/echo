import 'package:td_json_client/api/base.dart';

class AccountTtl extends TdObject {
  String get tdType => 'accountTtl';

  string? extra;
  int? client_id;
  int32? days;

  AccountTtl({
    this.extra,
    this.client_id,
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

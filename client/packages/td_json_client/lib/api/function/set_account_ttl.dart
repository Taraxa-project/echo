import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/account_ttl.dart';


/// Changes the period of inactivity after which the account of the current user will automatically be deleted 
class SetAccountTtl extends TdFunction {
  String get tdType => 'setAccountTtl';
  String get tdReturnType => 'Ok';


  /// New account TTL
  AccountTtl? ttl;

  SetAccountTtl({
    super.extra,
    super.client_id,
    this.ttl,
  });

  SetAccountTtl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['ttl'] != null) {
      ttl = TdApiMap.fromMap(map['ttl']) as AccountTtl;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'ttl': ttl?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

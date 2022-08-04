import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/premium_limit_type.dart';


/// Contains information about a limit, increased for Premium users 
class PremiumLimit extends TdObject {
  String get tdType => 'premiumLimit';


  /// The type of the limit 
  PremiumLimitType? type;

  /// Default value of the limit 
  int32? default_value;

  /// Value of the limit for Premium users
  int32? premium_value;

  PremiumLimit({
    super.extra,
    super.client_id,
    this.type,
    this.default_value,
    this.premium_value,
  });

  PremiumLimit.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as PremiumLimitType;
    }
    default_value = map['default_value'];
    premium_value = map['premium_value'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'default_value': default_value?.toMap(skipNulls: skipNulls),
      'premium_value': premium_value?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

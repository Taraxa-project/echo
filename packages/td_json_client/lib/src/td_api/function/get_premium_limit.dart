import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/premium_limit_type.dart';

/// Returns information about a limit, increased for Premium users. Returns a 404 error if the limit is unknown
class GetPremiumLimit extends TdFunction {
  String get tdType => 'getPremiumLimit';
  String get tdReturnType => 'PremiumLimit';

  /// Type of the limit
  PremiumLimitType? limit_type;

  GetPremiumLimit({
    super.extra,
    super.client_id,
    this.limit_type,
  });

  GetPremiumLimit.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['limit_type'] != null) {
      limit_type = TdApiMap.fromMap(map['limit_type']) as PremiumLimitType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'limit_type': limit_type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

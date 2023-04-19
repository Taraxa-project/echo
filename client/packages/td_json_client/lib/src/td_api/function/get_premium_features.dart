import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/premium_source.dart';

/// Returns information about features, available to Premium users
class GetPremiumFeatures extends TdFunction {
  String get tdType => 'getPremiumFeatures';
  String get tdReturnType => 'PremiumFeatures';

  /// Source of the request; pass null if the method is called from some non-standard source
  PremiumSource? source;

  GetPremiumFeatures({
    super.extra,
    super.client_id,
    this.source,
  });

  GetPremiumFeatures.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['source'] != null) {
      source = TdApiMap.fromMap(map['source']) as PremiumSource;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'source': source?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

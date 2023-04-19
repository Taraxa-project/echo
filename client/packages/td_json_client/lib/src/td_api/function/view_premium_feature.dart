import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/premium_feature.dart';

/// Informs TDLib that the user viewed detailed information about a Premium feature on the Premium features screen
class ViewPremiumFeature extends TdFunction {
  String get tdType => 'viewPremiumFeature';
  String get tdReturnType => 'Ok';

  /// The viewed premium feature
  PremiumFeature? feature;

  ViewPremiumFeature({
    super.extra,
    super.client_id,
    this.feature,
  });

  ViewPremiumFeature.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['feature'] != null) {
      feature = TdApiMap.fromMap(map['feature']) as PremiumFeature;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'feature': feature?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

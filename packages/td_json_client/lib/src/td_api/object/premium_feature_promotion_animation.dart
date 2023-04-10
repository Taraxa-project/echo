import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/premium_feature.dart';
import 'package:td_json_client/src/td_api/object/animation.dart';

/// Describes a promotion animation for a Premium feature
class PremiumFeaturePromotionAnimation extends TdObject {
  String get tdType => 'premiumFeaturePromotionAnimation';

  /// Premium feature
  PremiumFeature? feature;

  /// Promotion animation for the feature
  Animation? animation;

  PremiumFeaturePromotionAnimation({
    super.extra,
    super.client_id,
    this.feature,
    this.animation,
  });

  PremiumFeaturePromotionAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['feature'] != null) {
      feature = TdApiMap.fromMap(map['feature']) as PremiumFeature;
    }
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as Animation;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'feature': feature?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

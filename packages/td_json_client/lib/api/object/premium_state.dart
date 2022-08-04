import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/premium_feature_promotion_animation.dart';


/// Contains state of Telegram Premium subscription and promotion videos for Premium features
class PremiumState extends TdObject {
  String get tdType => 'premiumState';


  /// Text description of the state of the current Premium subscription; may be empty if the current user has no Telegram Premium subscription
  FormattedText? state;

  /// ISO 4217 currency code for Telegram Premium subscription payment
  string? currency;

  /// Monthly subscription payment for Telegram Premium subscription, in the smallest units of the currency
  int53? monthly_amount;

  /// The list of available promotion animations for Premium features
  vector<PremiumFeaturePromotionAnimation>? animations;

  PremiumState({
    super.extra,
    super.client_id,
    this.state,
    this.currency,
    this.monthly_amount,
    this.animations,
  });

  PremiumState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['state'] != null) {
      state = TdApiMap.fromMap(map['state']) as FormattedText;
    }
    currency = map['currency'];
    monthly_amount = map['monthly_amount'];
    if (map['animations'] != null) {
      animations = [];
      for (var someValue in map['animations']) {
        if (someValue != null) {
          animations?.add(TdApiMap.fromMap(someValue) as PremiumFeaturePromotionAnimation);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'state': state?.toMap(skipNulls: skipNulls),
      'currency': currency?.toMap(skipNulls: skipNulls),
      'monthly_amount': monthly_amount?.toMap(skipNulls: skipNulls),
      'animations': animations?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

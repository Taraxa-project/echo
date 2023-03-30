import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';
import 'package:td_json_client/src/td_api/object/premium_payment_option.dart';
import 'package:td_json_client/src/td_api/object/premium_feature_promotion_animation.dart';

/// Contains state of Telegram Premium subscription and promotion videos for Premium features
class PremiumState extends TdObject {
  String get tdType => 'premiumState';

  /// Text description of the state of the current Premium subscription; may be empty if the current user has no Telegram Premium subscription
  FormattedText? state;

  /// The list of available options for buying Telegram Premium
  vector<PremiumPaymentOption>? payment_options;

  /// The list of available promotion animations for Premium features
  vector<PremiumFeaturePromotionAnimation>? animations;

  PremiumState({
    super.extra,
    super.client_id,
    this.state,
    this.payment_options,
    this.animations,
  });

  PremiumState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['state'] != null) {
      state = TdApiMap.fromMap(map['state']) as FormattedText;
    }
    if (map['payment_options'] != null) {
      payment_options = [];
      for (var someValue in map['payment_options']) {
        if (someValue != null) {
          payment_options
              ?.add(TdApiMap.fromMap(someValue) as PremiumPaymentOption);
        }
      }
    }
    if (map['animations'] != null) {
      animations = [];
      for (var someValue in map['animations']) {
        if (someValue != null) {
          animations?.add(
              TdApiMap.fromMap(someValue) as PremiumFeaturePromotionAnimation);
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
      'payment_options': payment_options?.toMap(skipNulls: skipNulls),
      'animations': animations?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

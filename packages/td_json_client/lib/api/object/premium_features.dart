import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/premium_feature.dart';
import 'package:td_json_client/api/object/premium_limit.dart';
import 'package:td_json_client/api/object/internal_link_type.dart';


/// Contains information about features, available to Premium users 
class PremiumFeatures extends TdObject {
  String get tdType => 'premiumFeatures';


  /// The list of available features 
  vector<PremiumFeature>? features;

  /// The list of limits, increased for Premium users
  vector<PremiumLimit>? limits;

  /// An internal link to be opened to pay for Telegram Premium if store payment isn't possible; may be null if direct payment isn't available
  InternalLinkType? payment_link;

  PremiumFeatures({
    super.extra,
    super.client_id,
    this.features,
    this.limits,
    this.payment_link,
  });

  PremiumFeatures.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['features'] != null) {
      features = [];
      for (var someValue in map['features']) {
        if (someValue != null) {
          features?.add(TdApiMap.fromMap(someValue) as PremiumFeature);
        }
      }
    }
    if (map['limits'] != null) {
      limits = [];
      for (var someValue in map['limits']) {
        if (someValue != null) {
          limits?.add(TdApiMap.fromMap(someValue) as PremiumLimit);
        }
      }
    }
    if (map['payment_link'] != null) {
      payment_link = TdApiMap.fromMap(map['payment_link']) as InternalLinkType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'features': features?.toMap(skipNulls: skipNulls),
      'limits': limits?.toMap(skipNulls: skipNulls),
      'payment_link': payment_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

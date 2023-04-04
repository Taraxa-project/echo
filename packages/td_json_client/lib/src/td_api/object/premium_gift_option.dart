import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/internal_link_type.dart';

/// Describes an option for gifting Telegram Premium to a user
class PremiumGiftOption extends TdObject {
  String get tdType => 'premiumGiftOption';

  /// ISO 4217 currency code for Telegram Premium subscription payment
  string? currency;

  /// The amount to pay, in the smallest units of the currency
  int53? amount;

  /// The discount associated with this gift option, as a percentage
  int32? discount_percentage;

  /// Number of month the Telegram Premium subscription will be active
  int32? month_count;

  /// Identifier of the store product associated with the option
  string? store_product_id;

  /// An internal link to be opened for gifting Telegram Premium to the user if store payment isn't possible; may be null if direct payment isn't available
  InternalLinkType? payment_link;

  PremiumGiftOption({
    super.extra,
    super.client_id,
    this.currency,
    this.amount,
    this.discount_percentage,
    this.month_count,
    this.store_product_id,
    this.payment_link,
  });

  PremiumGiftOption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    currency = map['currency'];
    amount = map['amount'];
    discount_percentage = map['discount_percentage'];
    month_count = map['month_count'];
    store_product_id = map['store_product_id'];
    if (map['payment_link'] != null) {
      payment_link = TdApiMap.fromMap(map['payment_link']) as InternalLinkType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'currency': currency?.toMap(skipNulls: skipNulls),
      'amount': amount?.toMap(skipNulls: skipNulls),
      'discount_percentage': discount_percentage?.toMap(skipNulls: skipNulls),
      'month_count': month_count?.toMap(skipNulls: skipNulls),
      'store_product_id': store_product_id?.toMap(skipNulls: skipNulls),
      'payment_link': payment_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

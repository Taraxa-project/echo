import 'package:td_json_client/src/td_api/td.dart';

/// Describes a purpose of an in-store payment
abstract class StorePaymentPurpose extends TdObject {
  StorePaymentPurpose({super.extra, super.client_id});
}

/// The user subscribed to Telegram Premium
class StorePaymentPurposePremiumSubscription extends StorePaymentPurpose {
  String get tdType => 'storePaymentPurposePremiumSubscription';

  /// Pass true if this is a restore of a Telegram Premium purchase; only for App Store
  Bool? is_restore;

  /// Pass true if this is an upgrade from a monthly subscription to early subscription; only for App Store
  Bool? is_upgrade;

  StorePaymentPurposePremiumSubscription({
    super.extra,
    super.client_id,
    this.is_restore,
    this.is_upgrade,
  });

  StorePaymentPurposePremiumSubscription.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_restore = map['is_restore'];
    is_upgrade = map['is_upgrade'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_restore': is_restore?.toMap(skipNulls: skipNulls),
      'is_upgrade': is_upgrade?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user gifted Telegram Premium to another user
class StorePaymentPurposeGiftedPremium extends StorePaymentPurpose {
  String get tdType => 'storePaymentPurposeGiftedPremium';

  /// Identifier of the user for which Premium was gifted
  int53? user_id;

  /// ISO 4217 currency code of the payment currency
  string? currency;

  /// Paid amount, in the smallest units of the currency
  int53? amount;

  StorePaymentPurposeGiftedPremium({
    super.extra,
    super.client_id,
    this.user_id,
    this.currency,
    this.amount,
  });

  StorePaymentPurposeGiftedPremium.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    currency = map['currency'];
    amount = map['amount'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'currency': currency?.toMap(skipNulls: skipNulls),
      'amount': amount?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

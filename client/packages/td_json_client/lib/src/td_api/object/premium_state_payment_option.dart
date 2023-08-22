import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/premium_payment_option.dart';

/// Describes an option for buying or upgrading Telegram Premium for self
class PremiumStatePaymentOption extends TdObject {
  String get tdType => 'premiumStatePaymentOption';

  /// Information about the payment option
  PremiumPaymentOption? payment_option;

  /// True, if this is the currently used Telegram Premium subscription option
  Bool? is_current;

  /// True, if the payment option can be used to upgrade the existing Telegram Premium subscription
  Bool? is_upgrade;

  /// Identifier of the last in-store transaction for the currently used option
  string? last_transaction_id;

  PremiumStatePaymentOption({
    super.extra,
    super.client_id,
    this.payment_option,
    this.is_current,
    this.is_upgrade,
    this.last_transaction_id,
  });

  PremiumStatePaymentOption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['payment_option'] != null) {
      payment_option = TdApiMap.fromMap(map['payment_option']) as PremiumPaymentOption;
    }
    is_current = map['is_current'];
    is_upgrade = map['is_upgrade'];
    last_transaction_id = map['last_transaction_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'payment_option': payment_option?.toMap(skipNulls: skipNulls),
      'is_current': is_current?.toMap(skipNulls: skipNulls),
      'is_upgrade': is_upgrade?.toMap(skipNulls: skipNulls),
      'last_transaction_id': last_transaction_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

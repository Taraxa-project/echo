import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/labeled_price_part.dart';

/// Product invoice
class Invoice extends TdObject {
  String get tdType => 'invoice';

  /// ISO 4217 currency code
  string? currency;

  /// A list of objects used to calculate the total price of the product
  vector<LabeledPricePart>? price_parts;

  /// The maximum allowed amount of tip in the smallest units of the currency
  int53? max_tip_amount;

  /// Suggested amounts of tip in the smallest units of the currency
  vector<int53>? suggested_tip_amounts;

  /// An HTTP URL with terms of service for recurring payments. If non-empty, the invoice payment will result in recurring payments and the user must accept the terms of service before allowed to pay
  string? recurring_payment_terms_of_service_url;

  /// True, if the payment is a test payment
  Bool? is_test;

  /// True, if the user's name is needed for payment
  Bool? need_name;

  /// True, if the user's phone number is needed for payment
  Bool? need_phone_number;

  /// True, if the user's email address is needed for payment
  Bool? need_email_address;

  /// True, if the user's shipping address is needed for payment
  Bool? need_shipping_address;

  /// True, if the user's phone number will be sent to the provider
  Bool? send_phone_number_to_provider;

  /// True, if the user's email address will be sent to the provider
  Bool? send_email_address_to_provider;

  /// True, if the total price depends on the shipping method
  Bool? is_flexible;

  Invoice({
    super.extra,
    super.client_id,
    this.currency,
    this.price_parts,
    this.max_tip_amount,
    this.suggested_tip_amounts,
    this.recurring_payment_terms_of_service_url,
    this.is_test,
    this.need_name,
    this.need_phone_number,
    this.need_email_address,
    this.need_shipping_address,
    this.send_phone_number_to_provider,
    this.send_email_address_to_provider,
    this.is_flexible,
  });

  Invoice.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    currency = map['currency'];
    if (map['price_parts'] != null) {
      price_parts = [];
      for (var someValue in map['price_parts']) {
        if (someValue != null) {
          price_parts?.add(TdApiMap.fromMap(someValue) as LabeledPricePart);
        }
      }
    }
    max_tip_amount = map['max_tip_amount'];
    if (map['suggested_tip_amounts'] != null) {
      suggested_tip_amounts = [];
      for (var someValue in map['suggested_tip_amounts']) {
        suggested_tip_amounts?.add(someValue);
      }
    }
    recurring_payment_terms_of_service_url = map['recurring_payment_terms_of_service_url'];
    is_test = map['is_test'];
    need_name = map['need_name'];
    need_phone_number = map['need_phone_number'];
    need_email_address = map['need_email_address'];
    need_shipping_address = map['need_shipping_address'];
    send_phone_number_to_provider = map['send_phone_number_to_provider'];
    send_email_address_to_provider = map['send_email_address_to_provider'];
    is_flexible = map['is_flexible'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'currency': currency?.toMap(skipNulls: skipNulls),
      'price_parts': price_parts?.toMap(skipNulls: skipNulls),
      'max_tip_amount': max_tip_amount?.toMap(skipNulls: skipNulls),
      'suggested_tip_amounts': suggested_tip_amounts?.toMap(skipNulls: skipNulls),
      'recurring_payment_terms_of_service_url': recurring_payment_terms_of_service_url?.toMap(skipNulls: skipNulls),
      'is_test': is_test?.toMap(skipNulls: skipNulls),
      'need_name': need_name?.toMap(skipNulls: skipNulls),
      'need_phone_number': need_phone_number?.toMap(skipNulls: skipNulls),
      'need_email_address': need_email_address?.toMap(skipNulls: skipNulls),
      'need_shipping_address': need_shipping_address?.toMap(skipNulls: skipNulls),
      'send_phone_number_to_provider': send_phone_number_to_provider?.toMap(skipNulls: skipNulls),
      'send_email_address_to_provider': send_email_address_to_provider?.toMap(skipNulls: skipNulls),
      'is_flexible': is_flexible?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';


/// Stripe payment provider 
class PaymentsProviderStripe extends TdObject {
  String get tdType => 'paymentsProviderStripe';

  String? extra;
  int? client_id;

  /// Stripe API publishable key 
  string? publishable_key;

  /// True, if the user country must be provided 
  Bool? need_country;

  /// True, if the user ZIP/postal code must be provided 
  Bool? need_postal_code;

  /// True, if the cardholder name must be provided
  Bool? need_cardholder_name;

  PaymentsProviderStripe({
    this.extra,
    this.client_id,
    this.publishable_key,
    this.need_country,
    this.need_postal_code,
    this.need_cardholder_name,
  });

  PaymentsProviderStripe.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    publishable_key = map['publishable_key'];
    need_country = map['need_country'];
    need_postal_code = map['need_postal_code'];
    need_cardholder_name = map['need_cardholder_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'publishable_key': publishable_key?.toMap(skipNulls: skipNulls),
      'need_country': need_country?.toMap(skipNulls: skipNulls),
      'need_postal_code': need_postal_code?.toMap(skipNulls: skipNulls),
      'need_cardholder_name': need_cardholder_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

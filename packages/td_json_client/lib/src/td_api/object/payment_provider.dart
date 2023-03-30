import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about a payment provider
abstract class PaymentProvider extends TdObject {
  PaymentProvider({super.extra, super.client_id});
}

/// Smart Glocal payment provider
class PaymentProviderSmartGlocal extends PaymentProvider {
  String get tdType => 'paymentProviderSmartGlocal';

  /// Public payment token
  string? public_token;

  PaymentProviderSmartGlocal({
    super.extra,
    super.client_id,
    this.public_token,
  });

  PaymentProviderSmartGlocal.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    public_token = map['public_token'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'public_token': public_token?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Stripe payment provider
class PaymentProviderStripe extends PaymentProvider {
  String get tdType => 'paymentProviderStripe';

  /// Stripe API publishable key
  string? publishable_key;

  /// True, if the user country must be provided
  Bool? need_country;

  /// True, if the user ZIP/postal code must be provided
  Bool? need_postal_code;

  /// True, if the cardholder name must be provided
  Bool? need_cardholder_name;

  PaymentProviderStripe({
    super.extra,
    super.client_id,
    this.publishable_key,
    this.need_country,
    this.need_postal_code,
    this.need_cardholder_name,
  });

  PaymentProviderStripe.fromMap(Map<String, dynamic> map) {
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

/// Some other payment provider, for which a web payment form must be shown
class PaymentProviderOther extends PaymentProvider {
  String get tdType => 'paymentProviderOther';

  /// Payment form URL
  string? url;

  PaymentProviderOther({
    super.extra,
    super.client_id,
    this.url,
  });

  PaymentProviderOther.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

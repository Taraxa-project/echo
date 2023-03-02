import 'package:td_json_client/api/base.dart';

/// Contains the result of a payment request
class PaymentResult extends TdObject {
  String get tdType => 'paymentResult';

  /// True, if the payment request was successful; otherwise, the verification_url will be non-empty
  Bool? success;

  /// URL for additional payment credentials verification
  string? verification_url;

  PaymentResult({
    super.extra,
    super.client_id,
    this.success,
    this.verification_url,
  });

  PaymentResult.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    success = map['success'];
    verification_url = map['verification_url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'success': success?.toMap(skipNulls: skipNulls),
      'verification_url': verification_url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';

class PaymentResult extends TdObject {
  String get tdType => 'paymentResult';

  String? extra;
  int? client_id;
  Bool? success;
  string? verification_url;

  PaymentResult({
    this.extra,
    this.client_id,
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

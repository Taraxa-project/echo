import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/store_payment_purpose.dart';

/// Checks whether Telegram Premium purchase is possible. Must be called before in-store Premium purchase
class CanPurchasePremium extends TdFunction {
  String get tdType => 'canPurchasePremium';
  String get tdReturnType => 'Ok';

  /// Transaction purpose
  StorePaymentPurpose? purpose;

  CanPurchasePremium({
    super.extra,
    super.client_id,
    this.purpose,
  });

  CanPurchasePremium.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['purpose'] != null) {
      purpose = TdApiMap.fromMap(map['purpose']) as StorePaymentPurpose;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'purpose': purpose?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

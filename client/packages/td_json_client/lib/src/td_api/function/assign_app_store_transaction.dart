import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/store_payment_purpose.dart';

/// Informs server about a purchase through App Store. For official applications only
class AssignAppStoreTransaction extends TdFunction {
  String get tdType => 'assignAppStoreTransaction';
  String get tdReturnType => 'Ok';

  /// App Store receipt
  bytes? receipt;

  /// Transaction purpose
  StorePaymentPurpose? purpose;

  AssignAppStoreTransaction({
    super.extra,
    super.client_id,
    this.receipt,
    this.purpose,
  });

  AssignAppStoreTransaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    receipt = map['receipt'];
    if (map['purpose'] != null) {
      purpose = TdApiMap.fromMap(map['purpose']) as StorePaymentPurpose;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'receipt': receipt?.toMap(skipNulls: skipNulls),
      'purpose': purpose?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/store_payment_purpose.dart';

/// Informs server about a purchase through Google Play. For official applications only
class AssignGooglePlayTransaction extends TdFunction {
  String get tdType => 'assignGooglePlayTransaction';
  String get tdReturnType => 'Ok';

  /// Application package name
  string? package_name;

  /// Identifier of the purchased store product
  string? store_product_id;

  /// Google Play purchase token
  string? purchase_token;

  /// Transaction purpose
  StorePaymentPurpose? purpose;

  AssignGooglePlayTransaction({
    super.extra,
    super.client_id,
    this.package_name,
    this.store_product_id,
    this.purchase_token,
    this.purpose,
  });

  AssignGooglePlayTransaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    package_name = map['package_name'];
    store_product_id = map['store_product_id'];
    purchase_token = map['purchase_token'];
    if (map['purpose'] != null) {
      purpose = TdApiMap.fromMap(map['purpose']) as StorePaymentPurpose;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'package_name': package_name?.toMap(skipNulls: skipNulls),
      'store_product_id': store_product_id?.toMap(skipNulls: skipNulls),
      'purchase_token': purchase_token?.toMap(skipNulls: skipNulls),
      'purpose': purpose?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

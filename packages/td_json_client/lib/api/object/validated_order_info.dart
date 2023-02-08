import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/shipping_option.dart';

/// Contains a temporary identifier of validated order information, which is stored for one hour, and the available shipping options
class ValidatedOrderInfo extends TdObject {
  String get tdType => 'validatedOrderInfo';

  /// Temporary identifier of the order information
  string? order_info_id;

  /// Available shipping options
  vector<ShippingOption>? shipping_options;

  ValidatedOrderInfo({
    super.extra,
    super.client_id,
    this.order_info_id,
    this.shipping_options,
  });

  ValidatedOrderInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    order_info_id = map['order_info_id'];
    if (map['shipping_options'] != null) {
      shipping_options = [];
      for (var someValue in map['shipping_options']) {
        if (someValue != null) {
          shipping_options?.add(TdApiMap.fromMap(someValue) as ShippingOption);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'order_info_id': order_info_id?.toMap(skipNulls: skipNulls),
      'shipping_options': shipping_options?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

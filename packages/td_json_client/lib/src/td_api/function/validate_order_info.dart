import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_invoice.dart';
import 'package:td_json_client/src/td_api/object/order_info.dart';

/// Validates the order information provided by a user and returns the available shipping options for a flexible invoice
class ValidateOrderInfo extends TdFunction {
  String get tdType => 'validateOrderInfo';
  String get tdReturnType => 'ValidatedOrderInfo';

  /// The invoice
  InputInvoice? input_invoice;

  /// The order information, provided by the user; pass null if empty
  OrderInfo? order_info;

  /// Pass true to save the order information
  Bool? allow_save;

  ValidateOrderInfo({
    super.extra,
    super.client_id,
    this.input_invoice,
    this.order_info,
    this.allow_save,
  });

  ValidateOrderInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['input_invoice'] != null) {
      input_invoice = TdApiMap.fromMap(map['input_invoice']) as InputInvoice;
    }
    if (map['order_info'] != null) {
      order_info = TdApiMap.fromMap(map['order_info']) as OrderInfo;
    }
    allow_save = map['allow_save'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'input_invoice': input_invoice?.toMap(skipNulls: skipNulls),
      'order_info': order_info?.toMap(skipNulls: skipNulls),
      'allow_save': allow_save?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

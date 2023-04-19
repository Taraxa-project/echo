import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_invoice.dart';
import 'package:td_json_client/src/td_api/object/input_credentials.dart';

/// Sends a filled-out payment form to the bot for final verification
class SendPaymentForm extends TdFunction {
  String get tdType => 'sendPaymentForm';
  String get tdReturnType => 'PaymentResult';

  /// The invoice
  InputInvoice? input_invoice;

  /// Payment form identifier returned by getPaymentForm
  int64? payment_form_id;

  /// Identifier returned by validateOrderInfo, or an empty string
  string? order_info_id;

  /// Identifier of a chosen shipping option, if applicable
  string? shipping_option_id;

  /// The credentials chosen by user for payment
  InputCredentials? credentials;

  /// Chosen by the user amount of tip in the smallest units of the currency
  int53? tip_amount;

  SendPaymentForm({
    super.extra,
    super.client_id,
    this.input_invoice,
    this.payment_form_id,
    this.order_info_id,
    this.shipping_option_id,
    this.credentials,
    this.tip_amount,
  });

  SendPaymentForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['input_invoice'] != null) {
      input_invoice = TdApiMap.fromMap(map['input_invoice']) as InputInvoice;
    }
    payment_form_id = map['payment_form_id'];
    order_info_id = map['order_info_id'];
    shipping_option_id = map['shipping_option_id'];
    if (map['credentials'] != null) {
      credentials = TdApiMap.fromMap(map['credentials']) as InputCredentials;
    }
    tip_amount = map['tip_amount'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'input_invoice': input_invoice?.toMap(skipNulls: skipNulls),
      'payment_form_id': payment_form_id?.toMap(skipNulls: skipNulls),
      'order_info_id': order_info_id?.toMap(skipNulls: skipNulls),
      'shipping_option_id': shipping_option_id?.toMap(skipNulls: skipNulls),
      'credentials': credentials?.toMap(skipNulls: skipNulls),
      'tip_amount': tip_amount?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

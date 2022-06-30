import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_credentials.dart';


/// Sends a filled-out payment form to the bot for final verification 
class SendPaymentForm extends TdFunction {
  String get tdType => 'sendPaymentForm';
  String get tdReturnType => 'PaymentResult';


  /// Chat identifier of the Invoice message 
  int53? chat_id;

  /// Message identifier
  int53? message_id;

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
    this.chat_id,
    this.message_id,
    this.payment_form_id,
    this.order_info_id,
    this.shipping_option_id,
    this.credentials,
    this.tip_amount,
  });

  SendPaymentForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
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
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
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

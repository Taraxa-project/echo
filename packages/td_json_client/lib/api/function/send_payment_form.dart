import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_credentials.dart';

class SendPaymentForm extends TdFunction {
  String get tdType => 'sendPaymentForm';
  String get tdReturnType => 'PaymentResult';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  int64? payment_form_id;
  string? order_info_id;
  string? shipping_option_id;
  InputCredentials? credentials;
  int53? tip_amount;

  SendPaymentForm({
    this.extra,
    this.client_id,
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
    credentials = TdApiMap.fromMap(map['credentials']) as InputCredentials;
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

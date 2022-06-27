import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/photo.dart';
import 'package:td_json_client/api/object/invoice.dart';
import 'package:td_json_client/api/object/order_info.dart';
import 'package:td_json_client/api/object/shipping_option.dart';

class PaymentReceipt extends TdObject {
  String get tdType => 'paymentReceipt';

  string? extra;
  int? client_id;
  string? title;
  string? description;
  Photo? photo;
  int32? date;
  int53? seller_bot_user_id;
  int53? payments_provider_user_id;
  Invoice? invoice;
  OrderInfo? order_info;
  ShippingOption? shipping_option;
  string? credentials_title;
  int53? tip_amount;

  PaymentReceipt({
    this.extra,
    this.client_id,
    this.title,
    this.description,
    this.photo,
    this.date,
    this.seller_bot_user_id,
    this.payments_provider_user_id,
    this.invoice,
    this.order_info,
    this.shipping_option,
    this.credentials_title,
    this.tip_amount,
  });

  PaymentReceipt.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    description = map['description'];
    photo = TdApiMap.fromMap(map['photo']) as Photo;
    date = map['date'];
    seller_bot_user_id = map['seller_bot_user_id'];
    payments_provider_user_id = map['payments_provider_user_id'];
    invoice = TdApiMap.fromMap(map['invoice']) as Invoice;
    order_info = TdApiMap.fromMap(map['order_info']) as OrderInfo;
    shipping_option = TdApiMap.fromMap(map['shipping_option']) as ShippingOption;
    credentials_title = map['credentials_title'];
    tip_amount = map['tip_amount'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'seller_bot_user_id': seller_bot_user_id?.toMap(skipNulls: skipNulls),
      'payments_provider_user_id': payments_provider_user_id?.toMap(skipNulls: skipNulls),
      'invoice': invoice?.toMap(skipNulls: skipNulls),
      'order_info': order_info?.toMap(skipNulls: skipNulls),
      'shipping_option': shipping_option?.toMap(skipNulls: skipNulls),
      'credentials_title': credentials_title?.toMap(skipNulls: skipNulls),
      'tip_amount': tip_amount?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
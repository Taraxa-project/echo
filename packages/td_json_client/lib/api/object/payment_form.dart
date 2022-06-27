import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/invoice.dart';
import 'package:td_json_client/api/object/payments_provider_stripe.dart';
import 'package:td_json_client/api/object/order_info.dart';
import 'package:td_json_client/api/object/saved_credentials.dart';

class PaymentForm extends TdObject {
  String get tdType => 'paymentForm';

  String? extra;
  int? client_id;
  int64? id;
  Invoice? invoice;
  string? url;
  int53? seller_bot_user_id;
  int53? payments_provider_user_id;
  PaymentsProviderStripe? payments_provider;
  OrderInfo? saved_order_info;
  SavedCredentials? saved_credentials;
  Bool? can_save_credentials;
  Bool? need_password;

  PaymentForm({
    this.extra,
    this.client_id,
    this.id,
    this.invoice,
    this.url,
    this.seller_bot_user_id,
    this.payments_provider_user_id,
    this.payments_provider,
    this.saved_order_info,
    this.saved_credentials,
    this.can_save_credentials,
    this.need_password,
  });

  PaymentForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    invoice = TdApiMap.fromMap(map['invoice']) as Invoice;
    url = map['url'];
    seller_bot_user_id = map['seller_bot_user_id'];
    payments_provider_user_id = map['payments_provider_user_id'];
    payments_provider = TdApiMap.fromMap(map['payments_provider']) as PaymentsProviderStripe;
    saved_order_info = TdApiMap.fromMap(map['saved_order_info']) as OrderInfo;
    saved_credentials = TdApiMap.fromMap(map['saved_credentials']) as SavedCredentials;
    can_save_credentials = map['can_save_credentials'];
    need_password = map['need_password'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'invoice': invoice?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'seller_bot_user_id': seller_bot_user_id?.toMap(skipNulls: skipNulls),
      'payments_provider_user_id': payments_provider_user_id?.toMap(skipNulls: skipNulls),
      'payments_provider': payments_provider?.toMap(skipNulls: skipNulls),
      'saved_order_info': saved_order_info?.toMap(skipNulls: skipNulls),
      'saved_credentials': saved_credentials?.toMap(skipNulls: skipNulls),
      'can_save_credentials': can_save_credentials?.toMap(skipNulls: skipNulls),
      'need_password': need_password?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/invoice.dart';
import 'package:td_json_client/api/object/payment_provider.dart';
import 'package:td_json_client/api/object/order_info.dart';
import 'package:td_json_client/api/object/saved_credentials.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/photo.dart';


/// Contains information about an invoice payment form
class PaymentForm extends TdObject {
  String get tdType => 'paymentForm';


  /// The payment form identifier
  int64? id;

  /// Full information about the invoice
  Invoice? invoice;

  /// User identifier of the seller bot
  int53? seller_bot_user_id;

  /// User identifier of the payment provider bot
  int53? payment_provider_user_id;

  /// Information about the payment provider
  PaymentProvider? payment_provider;

  /// Saved server-side order information; may be null
  OrderInfo? saved_order_info;

  /// Information about saved card credentials; may be null
  SavedCredentials? saved_credentials;

  /// True, if the user can choose to save credentials
  Bool? can_save_credentials;

  /// True, if the user will be able to save credentials protected by a password they set up
  Bool? need_password;

  /// Product title
  string? product_title;

  /// Product description
  FormattedText? product_description;

  /// Product photo; may be null
  Photo? product_photo;

  PaymentForm({
    super.extra,
    super.client_id,
    this.id,
    this.invoice,
    this.seller_bot_user_id,
    this.payment_provider_user_id,
    this.payment_provider,
    this.saved_order_info,
    this.saved_credentials,
    this.can_save_credentials,
    this.need_password,
    this.product_title,
    this.product_description,
    this.product_photo,
  });

  PaymentForm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['invoice'] != null) {
      invoice = TdApiMap.fromMap(map['invoice']) as Invoice;
    }
    seller_bot_user_id = map['seller_bot_user_id'];
    payment_provider_user_id = map['payment_provider_user_id'];
    if (map['payment_provider'] != null) {
      payment_provider = TdApiMap.fromMap(map['payment_provider']) as PaymentProvider;
    }
    if (map['saved_order_info'] != null) {
      saved_order_info = TdApiMap.fromMap(map['saved_order_info']) as OrderInfo;
    }
    if (map['saved_credentials'] != null) {
      saved_credentials = TdApiMap.fromMap(map['saved_credentials']) as SavedCredentials;
    }
    can_save_credentials = map['can_save_credentials'];
    need_password = map['need_password'];
    product_title = map['product_title'];
    if (map['product_description'] != null) {
      product_description = TdApiMap.fromMap(map['product_description']) as FormattedText;
    }
    if (map['product_photo'] != null) {
      product_photo = TdApiMap.fromMap(map['product_photo']) as Photo;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'invoice': invoice?.toMap(skipNulls: skipNulls),
      'seller_bot_user_id': seller_bot_user_id?.toMap(skipNulls: skipNulls),
      'payment_provider_user_id': payment_provider_user_id?.toMap(skipNulls: skipNulls),
      'payment_provider': payment_provider?.toMap(skipNulls: skipNulls),
      'saved_order_info': saved_order_info?.toMap(skipNulls: skipNulls),
      'saved_credentials': saved_credentials?.toMap(skipNulls: skipNulls),
      'can_save_credentials': can_save_credentials?.toMap(skipNulls: skipNulls),
      'need_password': need_password?.toMap(skipNulls: skipNulls),
      'product_title': product_title?.toMap(skipNulls: skipNulls),
      'product_description': product_description?.toMap(skipNulls: skipNulls),
      'product_photo': product_photo?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

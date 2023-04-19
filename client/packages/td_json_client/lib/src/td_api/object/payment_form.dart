import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/invoice.dart';
import 'package:td_json_client/src/td_api/object/payment_provider.dart';
import 'package:td_json_client/src/td_api/object/payment_option.dart';
import 'package:td_json_client/src/td_api/object/order_info.dart';
import 'package:td_json_client/src/td_api/object/saved_credentials.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';
import 'package:td_json_client/src/td_api/object/photo.dart';

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

  /// The list of additional payment options
  vector<PaymentOption>? additional_payment_options;

  /// Saved server-side order information; may be null
  OrderInfo? saved_order_info;

  /// The list of saved payment credentials
  vector<SavedCredentials>? saved_credentials;

  /// True, if the user can choose to save credentials
  Bool? can_save_credentials;

  /// True, if the user will be able to save credentials, if sets up a 2-step verification password
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
    this.additional_payment_options,
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
    if (map['additional_payment_options'] != null) {
      additional_payment_options = [];
      for (var someValue in map['additional_payment_options']) {
        if (someValue != null) {
          additional_payment_options?.add(TdApiMap.fromMap(someValue) as PaymentOption);
        }
      }
    }
    if (map['saved_order_info'] != null) {
      saved_order_info = TdApiMap.fromMap(map['saved_order_info']) as OrderInfo;
    }
    if (map['saved_credentials'] != null) {
      saved_credentials = [];
      for (var someValue in map['saved_credentials']) {
        if (someValue != null) {
          saved_credentials?.add(TdApiMap.fromMap(someValue) as SavedCredentials);
        }
      }
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
      'additional_payment_options': additional_payment_options?.toMap(skipNulls: skipNulls),
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

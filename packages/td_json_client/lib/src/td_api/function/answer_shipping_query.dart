import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/shipping_option.dart';

/// Sets the result of a shipping query; for bots only
class AnswerShippingQuery extends TdFunction {
  String get tdType => 'answerShippingQuery';
  String get tdReturnType => 'Ok';

  /// Identifier of the shipping query
  int64? shipping_query_id;

  /// Available shipping options
  vector<ShippingOption>? shipping_options;

  /// An error message, empty on success
  string? error_message;

  AnswerShippingQuery({
    super.extra,
    super.client_id,
    this.shipping_query_id,
    this.shipping_options,
    this.error_message,
  });

  AnswerShippingQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    shipping_query_id = map['shipping_query_id'];
    if (map['shipping_options'] != null) {
      shipping_options = [];
      for (var someValue in map['shipping_options']) {
        if (someValue != null) {
          shipping_options?.add(TdApiMap.fromMap(someValue) as ShippingOption);
        }
      }
    }
    error_message = map['error_message'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'shipping_query_id': shipping_query_id?.toMap(skipNulls: skipNulls),
      'shipping_options': shipping_options?.toMap(skipNulls: skipNulls),
      'error_message': error_message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

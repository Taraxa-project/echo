import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/shipping_option.dart';

class AnswerShippingQuery extends TdFunction {
  String get tdType => 'answerShippingQuery';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int64? shipping_query_id;
  vector<ShippingOption>? shipping_options;
  string? error_message;

  AnswerShippingQuery({
    this.extra,
    this.client_id,
    this.shipping_query_id,
    this.shipping_options,
    this.error_message,
  });

  AnswerShippingQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    shipping_query_id = map['shipping_query_id'];
    if (map['shipping_options']) {
      shipping_options = [];
      for (var someValue in map['shipping_options']) {
        shipping_options?.add(TdApiMap.fromMap(someValue) as ShippingOption);
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

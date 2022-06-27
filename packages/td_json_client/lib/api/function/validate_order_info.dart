import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/order_info.dart';

class ValidateOrderInfo extends TdFunction {
  String get tdType => 'validateOrderInfo';
  String get tdReturnType => 'ValidatedOrderInfo';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  OrderInfo? order_info;
  Bool? allow_save;

  ValidateOrderInfo({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.order_info,
    this.allow_save,
  });

  ValidateOrderInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    order_info = TdApiMap.fromMap(map['order_info']) as OrderInfo;
    allow_save = map['allow_save'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'order_info': order_info?.toMap(skipNulls: skipNulls),
      'allow_save': allow_save?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

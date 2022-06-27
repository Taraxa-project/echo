import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/address.dart';

class OrderInfo extends TdObject {
  String get tdType => 'orderInfo';

  string? extra;
  int? client_id;
  string? name;
  string? phone_number;
  string? email_address;
  Address? shipping_address;

  OrderInfo({
    this.extra,
    this.client_id,
    this.name,
    this.phone_number,
    this.email_address,
    this.shipping_address,
  });

  OrderInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    phone_number = map['phone_number'];
    email_address = map['email_address'];
    shipping_address = TdApiMap.fromMap(map['shipping_address']) as Address;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
      'email_address': email_address?.toMap(skipNulls: skipNulls),
      'shipping_address': shipping_address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

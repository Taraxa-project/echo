import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/labeled_price_part.dart';

class ShippingOption extends TdObject {
  String get tdType => 'shippingOption';

  string? extra;
  int? client_id;
  string? id;
  string? title;
  vector<LabeledPricePart>? price_parts;

  ShippingOption({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.price_parts,
  });

  ShippingOption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    if (map['price_parts']) {
      price_parts = [];
      for (var someValue in map['price_parts']) {
        price_parts?.add(TdApiMap.fromMap(someValue) as LabeledPricePart);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'price_parts': price_parts?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

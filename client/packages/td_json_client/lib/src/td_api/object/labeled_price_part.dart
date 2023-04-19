import 'package:td_json_client/src/td_api/td.dart';

/// Portion of the price of a product (e.g., "delivery cost", "tax amount")
class LabeledPricePart extends TdObject {
  String get tdType => 'labeledPricePart';

  /// Label for this portion of the product price
  string? label;

  /// Currency amount in the smallest units of the currency
  int53? amount;

  LabeledPricePart({
    super.extra,
    super.client_id,
    this.label,
    this.amount,
  });

  LabeledPricePart.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    label = map['label'];
    amount = map['amount'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'label': label?.toMap(skipNulls: skipNulls),
      'amount': amount?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

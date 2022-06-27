import 'package:td_json_client/api/base.dart';

class LabeledPricePart extends TdObject {
  String get tdType => 'labeledPricePart';

  String? extra;
  int? client_id;
  string? label;
  int53? amount;

  LabeledPricePart({
    this.extra,
    this.client_id,
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

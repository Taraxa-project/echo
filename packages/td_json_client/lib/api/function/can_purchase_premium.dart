import 'package:td_json_client/api/base.dart';


/// Checks whether Telegram Premium purchase is possible. Must be called before in-store Premium purchase
class CanPurchasePremium extends TdFunction {
  String get tdType => 'canPurchasePremium';
  String get tdReturnType => 'Ok';


  CanPurchasePremium({
    super.extra,
    super.client_id,
  });

  CanPurchasePremium.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

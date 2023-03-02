import 'package:td_json_client/api/base.dart';


/// Informs TDLib that the user clicked Premium subscription button on the Premium features screen
class ClickPremiumSubscriptionButton extends TdFunction {
  String get tdType => 'clickPremiumSubscriptionButton';
  String get tdReturnType => 'Ok';


  ClickPremiumSubscriptionButton({
    super.extra,
    super.client_id,
  });

  ClickPremiumSubscriptionButton.fromMap(Map<String, dynamic> map) {
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

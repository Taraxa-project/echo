import 'package:td_json_client/api/base.dart';


/// Returns state of Telegram Premium subscription and promotion videos for Premium features
class GetPremiumState extends TdFunction {
  String get tdType => 'getPremiumState';
  String get tdReturnType => 'PremiumState';


  GetPremiumState({
    super.extra,
    super.client_id,
  });

  GetPremiumState.fromMap(Map<String, dynamic> map) {
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

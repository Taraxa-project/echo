import 'package:td_json_client/src/td_api/td.dart';

/// Resets all network data usage statistics to zero. Can be called before authorization
class ResetNetworkStatistics extends TdFunction {
  String get tdType => 'resetNetworkStatistics';
  String get tdReturnType => 'Ok';

  ResetNetworkStatistics({
    super.extra,
    super.client_id,
  });

  ResetNetworkStatistics.fromMap(Map<String, dynamic> map) {
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

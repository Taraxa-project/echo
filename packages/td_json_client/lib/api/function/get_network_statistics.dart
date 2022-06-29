import 'package:td_json_client/api/base.dart';


/// Returns network data usage statistics. Can be called before authorization 
class GetNetworkStatistics extends TdFunction {
  String get tdType => 'getNetworkStatistics';
  String get tdReturnType => 'NetworkStatistics';

  String? extra;
  int? client_id;

  /// If true, returns only data for the current library launch
  Bool? only_current;

  GetNetworkStatistics({
    this.extra,
    this.client_id,
    this.only_current,
  });

  GetNetworkStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    only_current = map['only_current'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'only_current': only_current?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

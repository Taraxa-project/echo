import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/network_statistics_entry.dart';


/// Adds the specified data to data usage statistics. Can be called before authorization 
class AddNetworkStatistics extends TdFunction {
  String get tdType => 'addNetworkStatistics';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// The network statistics entry with the data to be added to statistics
  NetworkStatisticsEntry? entry;

  AddNetworkStatistics({
    this.extra,
    this.client_id,
    this.entry,
  });

  AddNetworkStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    entry = TdApiMap.fromMap(map['entry']) as NetworkStatisticsEntry;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'entry': entry?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

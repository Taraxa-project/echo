import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/network_statistics_entry.dart';

class NetworkStatistics extends TdObject {
  String get tdType => 'networkStatistics';

  String? extra;
  int? client_id;
  int32? since_date;
  vector<NetworkStatisticsEntry>? entries;

  NetworkStatistics({
    this.extra,
    this.client_id,
    this.since_date,
    this.entries,
  });

  NetworkStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    since_date = map['since_date'];
    if (map['entries']) {
      entries = [];
      for (var someValue in map['entries']) {
        entries?.add(TdApiMap.fromMap(someValue) as NetworkStatisticsEntry);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'since_date': since_date?.toMap(skipNulls: skipNulls),
      'entries': entries?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';


/// Contains database statistics
class DatabaseStatistics extends TdObject {
  String get tdType => 'databaseStatistics';


  /// Database statistics in an unspecified human-readable format
  string? statistics;

  DatabaseStatistics({
    super.extra,
    super.client_id,
    this.statistics,
  });

  DatabaseStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    statistics = map['statistics'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'statistics': statistics?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

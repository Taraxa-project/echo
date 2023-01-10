import 'package:td_json_client/api/base.dart';


/// Contains number of being downloaded and recently downloaded files found
class DownloadedFileCounts extends TdObject {
  String get tdType => 'downloadedFileCounts';


  /// Number of active file downloads found, including paused
  int32? active_count;

  /// Number of paused file downloads found
  int32? paused_count;

  /// Number of completed file downloads found
  int32? completed_count;

  DownloadedFileCounts({
    super.extra,
    super.client_id,
    this.active_count,
    this.paused_count,
    this.completed_count,
  });

  DownloadedFileCounts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    active_count = map['active_count'];
    paused_count = map['paused_count'];
    completed_count = map['completed_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'active_count': active_count?.toMap(skipNulls: skipNulls),
      'paused_count': paused_count?.toMap(skipNulls: skipNulls),
      'completed_count': completed_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

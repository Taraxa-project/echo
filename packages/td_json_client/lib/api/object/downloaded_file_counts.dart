import 'package:td_json_client/api/base.dart';

class DownloadedFileCounts extends TdObject {
  String get tdType => 'downloadedFileCounts';

  string? extra;
  int? client_id;
  int32? active_count;
  int32? paused_count;
  int32? completed_count;

  DownloadedFileCounts({
    this.extra,
    this.client_id,
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

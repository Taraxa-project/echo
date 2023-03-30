import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/downloaded_file_counts.dart';
import 'package:td_json_client/src/td_api/object/file_download.dart';

/// Contains a list of downloaded files, found by a search
class FoundFileDownloads extends TdObject {
  String get tdType => 'foundFileDownloads';

  /// Total number of suitable files, ignoring offset
  DownloadedFileCounts? total_counts;

  /// The list of files
  vector<FileDownload>? files;

  /// The offset for the next request. If empty, there are no more results
  string? next_offset;

  FoundFileDownloads({
    super.extra,
    super.client_id,
    this.total_counts,
    this.files,
    this.next_offset,
  });

  FoundFileDownloads.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['total_counts'] != null) {
      total_counts =
          TdApiMap.fromMap(map['total_counts']) as DownloadedFileCounts;
    }
    if (map['files'] != null) {
      files = [];
      for (var someValue in map['files']) {
        if (someValue != null) {
          files?.add(TdApiMap.fromMap(someValue) as FileDownload);
        }
      }
    }
    next_offset = map['next_offset'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_counts': total_counts?.toMap(skipNulls: skipNulls),
      'files': files?.toMap(skipNulls: skipNulls),
      'next_offset': next_offset?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

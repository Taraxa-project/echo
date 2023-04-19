import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/local_file.dart';
import 'package:td_json_client/src/td_api/object/remote_file.dart';

/// Represents a file
class File extends TdObject {
  String get tdType => 'file';

  /// Unique file identifier
  int32? id;

  /// File size, in bytes; 0 if unknown
  int53? size;

  /// Approximate file size in bytes in case the exact file size is unknown. Can be used to show download/upload progress
  int53? expected_size;

  /// Information about the local copy of the file
  LocalFile? local;

  /// Information about the remote copy of the file
  RemoteFile? remote;

  File({
    super.extra,
    super.client_id,
    this.id,
    this.size,
    this.expected_size,
    this.local,
    this.remote,
  });

  File.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    size = map['size'];
    expected_size = map['expected_size'];
    if (map['local'] != null) {
      local = TdApiMap.fromMap(map['local']) as LocalFile;
    }
    if (map['remote'] != null) {
      remote = TdApiMap.fromMap(map['remote']) as RemoteFile;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'size': size?.toMap(skipNulls: skipNulls),
      'expected_size': expected_size?.toMap(skipNulls: skipNulls),
      'local': local?.toMap(skipNulls: skipNulls),
      'remote': remote?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

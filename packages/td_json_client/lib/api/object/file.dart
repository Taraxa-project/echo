import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/local_file.dart';
import 'package:td_json_client/api/object/remote_file.dart';

class File extends TdObject {
  String get tdType => 'file';

  string? extra;
  int? client_id;
  int32? id;
  int32? size;
  int32? expected_size;
  LocalFile? local;
  RemoteFile? remote;

  File({
    this.extra,
    this.client_id,
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
    local = TdApiMap.fromMap(map['local']) as LocalFile;
    remote = TdApiMap.fromMap(map['remote']) as RemoteFile;
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

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file_type.dart';

class GetRemoteFile extends TdFunction {
  String get tdType => 'getRemoteFile';
  String get tdReturnType => 'File';

  string? extra;
  int? client_id;
  string? remote_file_id;
  FileType? file_type;

  GetRemoteFile({
    this.extra,
    this.client_id,
    this.remote_file_id,
    this.file_type,
  });

  GetRemoteFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    remote_file_id = map['remote_file_id'];
    file_type = TdApiMap.fromMap(map['file_type']) as FileType;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'remote_file_id': remote_file_id?.toMap(skipNulls: skipNulls),
      'file_type': file_type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

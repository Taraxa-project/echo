import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/file_type.dart';

/// Returns information about a file by its remote ID; this is an offline request. Can be used to register a URL as a file for further uploading, or sending as a message. Even the request succeeds, the file can be used only if it is still accessible to the user.
/// For example, if the file is from a message, then the message must be not deleted and accessible to the user. If the file database is disabled, then the corresponding object with the file must be preloaded by the application
class GetRemoteFile extends TdFunction {
  String get tdType => 'getRemoteFile';
  String get tdReturnType => 'File';

  /// Remote identifier of the file to get
  string? remote_file_id;

  /// File type; pass null if unknown
  FileType? file_type;

  GetRemoteFile({
    super.extra,
    super.client_id,
    this.remote_file_id,
    this.file_type,
  });

  GetRemoteFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    remote_file_id = map['remote_file_id'];
    if (map['file_type'] != null) {
      file_type = TdApiMap.fromMap(map['file_type']) as FileType;
    }
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

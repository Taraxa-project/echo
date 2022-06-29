import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';
import 'package:td_json_client/api/object/file_type.dart';


/// Asynchronously uploads a file to the cloud without sending it in a message. updateFile will be used to notify about upload progress and successful completion of the upload. The file will not have a persistent remote identifier until it will be sent in a message
class UploadFile extends TdFunction {
  String get tdType => 'uploadFile';
  String get tdReturnType => 'File';

  String? extra;
  int? client_id;

  /// File to upload
  InputFile? file;

  /// File type; pass null if unknown
  FileType? file_type;

  /// Priority of the upload (1-32). The higher the priority, the earlier the file will be uploaded. If the priorities of two files are equal, then the first one for which uploadFile was called will be uploaded first
  int32? priority;

  UploadFile({
    this.extra,
    this.client_id,
    this.file,
    this.file_type,
    this.priority,
  });

  UploadFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['file'] != null) {
      file = TdApiMap.fromMap(map['file']) as InputFile;
    }
    if (map['file_type'] != null) {
      file_type = TdApiMap.fromMap(map['file_type']) as FileType;
    }
    priority = map['priority'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file': file?.toMap(skipNulls: skipNulls),
      'file_type': file_type?.toMap(skipNulls: skipNulls),
      'priority': priority?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

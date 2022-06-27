import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';
import 'package:td_json_client/api/object/file_type.dart';

class UploadFile extends TdFunction {
  String get tdType => 'uploadFile';
  String get tdReturnType => 'File';

  String? extra;
  int? client_id;
  InputFile? file;
  FileType? file_type;
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
    file = TdApiMap.fromMap(map['file']) as InputFile;
    file_type = TdApiMap.fromMap(map['file_type']) as FileType;
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

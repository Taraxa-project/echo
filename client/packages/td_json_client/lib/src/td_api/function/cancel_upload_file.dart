import 'package:td_json_client/src/td_api/td.dart';

/// Stops the uploading of a file. Supported only for files uploaded by using uploadFile. For other files the behavior is undefined
class CancelUploadFile extends TdFunction {
  String get tdType => 'cancelUploadFile';
  String get tdReturnType => 'Ok';

  /// Identifier of the file to stop uploading
  int32? file_id;

  CancelUploadFile({
    super.extra,
    super.client_id,
    this.file_id,
  });

  CancelUploadFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

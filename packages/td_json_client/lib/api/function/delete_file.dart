import 'package:td_json_client/api/base.dart';


/// Deletes a file from the TDLib file cache 
class DeleteFile extends TdFunction {
  String get tdType => 'deleteFile';
  String get tdReturnType => 'Ok';


  /// Identifier of the file to delete
  int32? file_id;

  DeleteFile({
    super.extra,
    super.client_id,
    this.file_id,
  });

  DeleteFile.fromMap(Map<String, dynamic> map) {
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

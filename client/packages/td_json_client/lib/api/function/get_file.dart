import 'package:td_json_client/api/base.dart';


/// Returns information about a file; this is an offline request 
class GetFile extends TdFunction {
  String get tdType => 'getFile';
  String get tdReturnType => 'File';


  /// Identifier of the file to get
  int32? file_id;

  GetFile({
    super.extra,
    super.client_id,
    this.file_id,
  });

  GetFile.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/api/base.dart';

class GetFile extends TdFunction {
  String get tdType => 'getFile';
  String get tdReturnType => 'File';

  string? extra;
  int? client_id;
  int32? file_id;

  GetFile({
    this.extra,
    this.client_id,
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

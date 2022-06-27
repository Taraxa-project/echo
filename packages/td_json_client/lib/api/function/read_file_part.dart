import 'package:td_json_client/api/base.dart';

class ReadFilePart extends TdFunction {
  String get tdType => 'readFilePart';
  String get tdReturnType => 'FilePart';

  string? extra;
  int? client_id;
  int32? file_id;
  int32? offset;
  int32? count;

  ReadFilePart({
    this.extra,
    this.client_id,
    this.file_id,
    this.offset,
    this.count,
  });

  ReadFilePart.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    offset = map['offset'];
    count = map['count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'count': count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

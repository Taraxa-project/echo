import 'package:td_json_client/api/base.dart';

class DownloadFile extends TdFunction {
  String get tdType => 'downloadFile';
  String get tdReturnType => 'File';

  String? extra;
  int? client_id;
  int32? file_id;
  int32? priority;
  int32? offset;
  int32? limit;
  Bool? synchronous;

  DownloadFile({
    this.extra,
    this.client_id,
    this.file_id,
    this.priority,
    this.offset,
    this.limit,
    this.synchronous,
  });

  DownloadFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    priority = map['priority'];
    offset = map['offset'];
    limit = map['limit'];
    synchronous = map['synchronous'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'priority': priority?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'synchronous': synchronous?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

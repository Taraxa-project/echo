import 'package:td_json_client/api/base.dart';


/// Downloads a file from the cloud. Download progress and completion of the download will be notified through updateFile updates
class DownloadFile extends TdFunction {
  String get tdType => 'downloadFile';
  String get tdReturnType => 'File';


  /// Identifier of the file to download
  int32? file_id;

  /// Priority of the download (1-32). The higher the priority, the earlier the file will be downloaded. If the priorities of two files are equal, then the last one for which downloadFile was called will be downloaded first
  int32? priority;

  /// The starting position from which the file needs to be downloaded
  int32? offset;

  /// Number of bytes which need to be downloaded starting from the "offset" position before the download will automatically be canceled; use 0 to download without a limit
  int32? limit;

  /// If false, this request returns file state just after the download has been started. If true, this request returns file state only after
  /// the download has succeeded, has failed, has been canceled or a new downloadFile request with different offset/limit parameters was sent
  Bool? synchronous;

  DownloadFile({
    super.extra,
    super.client_id,
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

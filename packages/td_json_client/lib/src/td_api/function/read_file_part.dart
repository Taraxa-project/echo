import 'package:td_json_client/src/td_api/td.dart';

/// Reads a part of a file from the TDLib file cache and returns read bytes. This method is intended to be used only if the application has no direct access to TDLib's file system, because it is usually slower than a direct read from the file
class ReadFilePart extends TdFunction {
  String get tdType => 'readFilePart';
  String get tdReturnType => 'FilePart';

  /// Identifier of the file. The file must be located in the TDLib file cache
  int32? file_id;

  /// The offset from which to read the file
  int53? offset;

  /// Number of bytes to read. An error will be returned if there are not enough bytes available in the file from the specified position. Pass 0 to read all available data from the specified position
  int53? count;

  ReadFilePart({
    super.extra,
    super.client_id,
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

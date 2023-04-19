import 'package:td_json_client/src/td_api/td.dart';

/// Returns file downloaded prefix size from a given offset, in bytes
class GetFileDownloadedPrefixSize extends TdFunction {
  String get tdType => 'getFileDownloadedPrefixSize';
  String get tdReturnType => 'FileDownloadedPrefixSize';

  /// Identifier of the file
  int32? file_id;

  /// Offset from which downloaded prefix size needs to be calculated
  int53? offset;

  GetFileDownloadedPrefixSize({
    super.extra,
    super.client_id,
    this.file_id,
    this.offset,
  });

  GetFileDownloadedPrefixSize.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    offset = map['offset'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

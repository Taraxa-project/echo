import 'package:td_json_client/src/td_api/td.dart';

/// Removes a file from the file download list
class RemoveFileFromDownloads extends TdFunction {
  String get tdType => 'removeFileFromDownloads';
  String get tdReturnType => 'Ok';

  /// Identifier of the downloaded file
  int32? file_id;

  /// Pass true to delete the file from the TDLib file cache
  Bool? delete_from_cache;

  RemoveFileFromDownloads({
    super.extra,
    super.client_id,
    this.file_id,
    this.delete_from_cache,
  });

  RemoveFileFromDownloads.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    delete_from_cache = map['delete_from_cache'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'delete_from_cache': delete_from_cache?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file_type.dart';


/// Contains the storage usage statistics for a specific file type 
class StorageStatisticsByFileType extends TdObject {
  String get tdType => 'storageStatisticsByFileType';


  /// File type 
  FileType? file_type;

  /// Total size of the files, in bytes 
  int53? size;

  /// Total number of files
  int32? count;

  StorageStatisticsByFileType({
    super.extra,
    super.client_id,
    this.file_type,
    this.size,
    this.count,
  });

  StorageStatisticsByFileType.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['file_type'] != null) {
      file_type = TdApiMap.fromMap(map['file_type']) as FileType;
    }
    size = map['size'];
    count = map['count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_type': file_type?.toMap(skipNulls: skipNulls),
      'size': size?.toMap(skipNulls: skipNulls),
      'count': count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

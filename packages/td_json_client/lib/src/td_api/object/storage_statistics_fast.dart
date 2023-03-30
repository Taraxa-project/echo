import 'package:td_json_client/src/td_api/td.dart';

/// Contains approximate storage usage statistics, excluding files of unknown file type
class StorageStatisticsFast extends TdObject {
  String get tdType => 'storageStatisticsFast';

  /// Approximate total size of files, in bytes
  int53? files_size;

  /// Approximate number of files
  int32? file_count;

  /// Size of the database
  int53? database_size;

  /// Size of the language pack database
  int53? language_pack_database_size;

  /// Size of the TDLib internal log
  int53? log_size;

  StorageStatisticsFast({
    super.extra,
    super.client_id,
    this.files_size,
    this.file_count,
    this.database_size,
    this.language_pack_database_size,
    this.log_size,
  });

  StorageStatisticsFast.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    files_size = map['files_size'];
    file_count = map['file_count'];
    database_size = map['database_size'];
    language_pack_database_size = map['language_pack_database_size'];
    log_size = map['log_size'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'files_size': files_size?.toMap(skipNulls: skipNulls),
      'file_count': file_count?.toMap(skipNulls: skipNulls),
      'database_size': database_size?.toMap(skipNulls: skipNulls),
      'language_pack_database_size':
          language_pack_database_size?.toMap(skipNulls: skipNulls),
      'log_size': log_size?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

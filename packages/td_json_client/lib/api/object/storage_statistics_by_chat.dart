import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/storage_statistics_by_file_type.dart';


/// Contains the storage usage statistics for a specific chat 
class StorageStatisticsByChat extends TdObject {
  String get tdType => 'storageStatisticsByChat';

  String? extra;
  int? client_id;

  /// Chat identifier; 0 if none 
  int53? chat_id;

  /// Total size of the files in the chat, in bytes 
  int53? size;

  /// Total number of files in the chat 
  int32? count;

  /// Statistics split by file types
  vector<StorageStatisticsByFileType>? by_file_type;

  StorageStatisticsByChat({
    this.extra,
    this.client_id,
    this.chat_id,
    this.size,
    this.count,
    this.by_file_type,
  });

  StorageStatisticsByChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    size = map['size'];
    count = map['count'];
    if (map['by_file_type']) {
      by_file_type = [];
      for (var someValue in map['by_file_type']) {
        by_file_type?.add(TdApiMap.fromMap(someValue) as StorageStatisticsByFileType);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'size': size?.toMap(skipNulls: skipNulls),
      'count': count?.toMap(skipNulls: skipNulls),
      'by_file_type': by_file_type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/storage_statistics_by_chat.dart';

/// Contains the exact storage usage statistics split by chats and file type
class StorageStatistics extends TdObject {
  String get tdType => 'storageStatistics';

  /// Total size of files, in bytes
  int53? size;

  /// Total number of files
  int32? count;

  /// Statistics split by chats
  vector<StorageStatisticsByChat>? by_chat;

  StorageStatistics({
    super.extra,
    super.client_id,
    this.size,
    this.count,
    this.by_chat,
  });

  StorageStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    size = map['size'];
    count = map['count'];
    if (map['by_chat'] != null) {
      by_chat = [];
      for (var someValue in map['by_chat']) {
        if (someValue != null) {
          by_chat?.add(TdApiMap.fromMap(someValue) as StorageStatisticsByChat);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'size': size?.toMap(skipNulls: skipNulls),
      'count': count?.toMap(skipNulls: skipNulls),
      'by_chat': by_chat?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

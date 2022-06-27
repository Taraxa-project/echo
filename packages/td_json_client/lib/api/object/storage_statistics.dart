import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/storage_statistics_by_chat.dart';

class StorageStatistics extends TdObject {
  String get tdType => 'storageStatistics';

  string? extra;
  int? client_id;
  int53? size;
  int32? count;
  vector<StorageStatisticsByChat>? by_chat;

  StorageStatistics({
    this.extra,
    this.client_id,
    this.size,
    this.count,
    this.by_chat,
  });

  StorageStatistics.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    size = map['size'];
    count = map['count'];
    if (map['by_chat']) {
      by_chat = [];
      for (var someValue in map['by_chat']) {
        by_chat?.add(TdApiMap.fromMap(someValue) as StorageStatisticsByChat);
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

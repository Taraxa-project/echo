import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file_type.dart';

class OptimizeStorage extends TdFunction {
  String get tdType => 'optimizeStorage';
  String get tdReturnType => 'StorageStatistics';

  String? extra;
  int? client_id;
  int53? size;
  int32? ttl;
  int32? count;
  int32? immunity_delay;
  vector<FileType>? file_types;
  vector<int53>? chat_ids;
  vector<int53>? exclude_chat_ids;
  Bool? return_deleted_file_statistics;
  int32? chat_limit;

  OptimizeStorage({
    this.extra,
    this.client_id,
    this.size,
    this.ttl,
    this.count,
    this.immunity_delay,
    this.file_types,
    this.chat_ids,
    this.exclude_chat_ids,
    this.return_deleted_file_statistics,
    this.chat_limit,
  });

  OptimizeStorage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    size = map['size'];
    ttl = map['ttl'];
    count = map['count'];
    immunity_delay = map['immunity_delay'];
    if (map['file_types']) {
      file_types = [];
      for (var someValue in map['file_types']) {
        file_types?.add(TdApiMap.fromMap(someValue) as FileType);
      }
    }
    if (map['chat_ids']) {
      chat_ids = [];
      for (var someValue in map['chat_ids']) {
        chat_ids?.add(someValue);
      }
    }
    if (map['exclude_chat_ids']) {
      exclude_chat_ids = [];
      for (var someValue in map['exclude_chat_ids']) {
        exclude_chat_ids?.add(someValue);
      }
    }
    return_deleted_file_statistics = map['return_deleted_file_statistics'];
    chat_limit = map['chat_limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'size': size?.toMap(skipNulls: skipNulls),
      'ttl': ttl?.toMap(skipNulls: skipNulls),
      'count': count?.toMap(skipNulls: skipNulls),
      'immunity_delay': immunity_delay?.toMap(skipNulls: skipNulls),
      'file_types': file_types?.toMap(skipNulls: skipNulls),
      'chat_ids': chat_ids?.toMap(skipNulls: skipNulls),
      'exclude_chat_ids': exclude_chat_ids?.toMap(skipNulls: skipNulls),
      'return_deleted_file_statistics': return_deleted_file_statistics?.toMap(skipNulls: skipNulls),
      'chat_limit': chat_limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

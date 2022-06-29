import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file_type.dart';


/// Optimizes storage usage, i.e. deletes some files and returns new storage usage statistics. Secret thumbnails can't be deleted
class OptimizeStorage extends TdFunction {
  String get tdType => 'optimizeStorage';
  String get tdReturnType => 'StorageStatistics';

  String? extra;
  int? client_id;

  /// Limit on the total size of files after deletion, in bytes. Pass -1 to use the default limit
  int53? size;

  /// Limit on the time that has passed since the last time a file was accessed (or creation time for some filesystems). Pass -1 to use the default limit
  int32? ttl;

  /// Limit on the total number of files after deletion. Pass -1 to use the default limit
  int32? count;

  /// The amount of time after the creation of a file during which it can't be deleted, in seconds. Pass -1 to use the default value
  int32? immunity_delay;

  /// If non-empty, only files with the given types are considered. By default, all types except thumbnails, profile photos, stickers and wallpapers are deleted
  vector<FileType>? file_types;

  /// If non-empty, only files from the given chats are considered. Use 0 as chat identifier to delete files not belonging to any chat (e.g., profile photos)
  vector<int53>? chat_ids;

  /// If non-empty, files from the given chats are excluded. Use 0 as chat identifier to exclude all files not belonging to any chat (e.g., profile photos)
  vector<int53>? exclude_chat_ids;

  /// Pass true if statistics about the files that were deleted must be returned instead of the whole storage usage statistics. Affects only returned statistics
  Bool? return_deleted_file_statistics;

  /// Same as in getStorageStatistics. Affects only returned statistics
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
    if (map['file_types'] != null) {
      file_types = [];
      for (var someValue in map['file_types']) {
        if (someValue != null) {
          file_types?.add(TdApiMap.fromMap(someValue) as FileType);
        }
      }
    }
    if (map['chat_ids'] != null) {
      chat_ids = [];
      for (var someValue in map['chat_ids']) {
        chat_ids?.add(someValue);
      }
    }
    if (map['exclude_chat_ids'] != null) {
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

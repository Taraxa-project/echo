import 'package:td_json_client/api/base.dart';

class LocalFile extends TdObject {
  String get tdType => 'localFile';

  string? extra;
  int? client_id;
  string? path;
  Bool? can_be_downloaded;
  Bool? can_be_deleted;
  Bool? is_downloading_active;
  Bool? is_downloading_completed;
  int32? download_offset;
  int32? downloaded_prefix_size;
  int32? downloaded_size;

  LocalFile({
    this.extra,
    this.client_id,
    this.path,
    this.can_be_downloaded,
    this.can_be_deleted,
    this.is_downloading_active,
    this.is_downloading_completed,
    this.download_offset,
    this.downloaded_prefix_size,
    this.downloaded_size,
  });

  LocalFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    path = map['path'];
    can_be_downloaded = map['can_be_downloaded'];
    can_be_deleted = map['can_be_deleted'];
    is_downloading_active = map['is_downloading_active'];
    is_downloading_completed = map['is_downloading_completed'];
    download_offset = map['download_offset'];
    downloaded_prefix_size = map['downloaded_prefix_size'];
    downloaded_size = map['downloaded_size'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'path': path?.toMap(skipNulls: skipNulls),
      'can_be_downloaded': can_be_downloaded?.toMap(skipNulls: skipNulls),
      'can_be_deleted': can_be_deleted?.toMap(skipNulls: skipNulls),
      'is_downloading_active': is_downloading_active?.toMap(skipNulls: skipNulls),
      'is_downloading_completed': is_downloading_completed?.toMap(skipNulls: skipNulls),
      'download_offset': download_offset?.toMap(skipNulls: skipNulls),
      'downloaded_prefix_size': downloaded_prefix_size?.toMap(skipNulls: skipNulls),
      'downloaded_size': downloaded_size?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

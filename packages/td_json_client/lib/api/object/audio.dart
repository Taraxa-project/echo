import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';

class Audio extends TdObject {
  String get tdType => 'audio';

  string? extra;
  int? client_id;
  int32? duration;
  string? title;
  string? performer;
  string? file_name;
  string? mime_type;
  Minithumbnail? album_cover_minithumbnail;
  Thumbnail? album_cover_thumbnail;
  File? audio;

  Audio({
    this.extra,
    this.client_id,
    this.duration,
    this.title,
    this.performer,
    this.file_name,
    this.mime_type,
    this.album_cover_minithumbnail,
    this.album_cover_thumbnail,
    this.audio,
  });

  Audio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    duration = map['duration'];
    title = map['title'];
    performer = map['performer'];
    file_name = map['file_name'];
    mime_type = map['mime_type'];
    album_cover_minithumbnail = TdApiMap.fromMap(map['album_cover_minithumbnail']) as Minithumbnail;
    album_cover_thumbnail = TdApiMap.fromMap(map['album_cover_thumbnail']) as Thumbnail;
    audio = TdApiMap.fromMap(map['audio']) as File;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'performer': performer?.toMap(skipNulls: skipNulls),
      'file_name': file_name?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
      'album_cover_minithumbnail': album_cover_minithumbnail?.toMap(skipNulls: skipNulls),
      'album_cover_thumbnail': album_cover_thumbnail?.toMap(skipNulls: skipNulls),
      'audio': audio?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

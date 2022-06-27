import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';

class VideoNote extends TdObject {
  String get tdType => 'videoNote';

  string? extra;
  int? client_id;
  int32? duration;
  int32? length;
  Minithumbnail? minithumbnail;
  Thumbnail? thumbnail;
  File? video;

  VideoNote({
    this.extra,
    this.client_id,
    this.duration,
    this.length,
    this.minithumbnail,
    this.thumbnail,
    this.video,
  });

  VideoNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    duration = map['duration'];
    length = map['length'];
    minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    video = TdApiMap.fromMap(map['video']) as File;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
      'minithumbnail': minithumbnail?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

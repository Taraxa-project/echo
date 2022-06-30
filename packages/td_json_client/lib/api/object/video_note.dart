import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';


/// Describes a video note. The video must be equal in width and height, cropped to a circle, and stored in MPEG4 format 
class VideoNote extends TdObject {
  String get tdType => 'videoNote';


  /// Duration of the video, in seconds; as defined by the sender
  int32? duration;

  /// Video width and height; as defined by the sender 
  int32? length;

  /// Video minithumbnail; may be null
  Minithumbnail? minithumbnail;

  /// Video thumbnail in JPEG format; as defined by the sender; may be null 
  Thumbnail? thumbnail;

  /// File containing the video
  File? video;

  VideoNote({
    super.extra,
    super.client_id,
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
    if (map['minithumbnail'] != null) {
      minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    }
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as File;
    }
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

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';

/// Describes a video file
class Video extends TdObject {
  String get tdType => 'video';

  /// Duration of the video, in seconds; as defined by the sender
  int32? duration;

  /// Video width; as defined by the sender
  int32? width;

  /// Video height; as defined by the sender
  int32? height;

  /// Original name of the file; as defined by the sender
  string? file_name;

  /// MIME type of the file; as defined by the sender
  string? mime_type;

  /// True, if stickers were added to the video. The list of corresponding sticker sets can be received using getAttachedStickerSets
  Bool? has_stickers;

  /// True, if the video is supposed to be streamed
  Bool? supports_streaming;

  /// Video minithumbnail; may be null
  Minithumbnail? minithumbnail;

  /// Video thumbnail in JPEG or MPEG4 format; as defined by the sender; may be null
  Thumbnail? thumbnail;

  /// File containing the video
  File? video;

  Video({
    super.extra,
    super.client_id,
    this.duration,
    this.width,
    this.height,
    this.file_name,
    this.mime_type,
    this.has_stickers,
    this.supports_streaming,
    this.minithumbnail,
    this.thumbnail,
    this.video,
  });

  Video.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    duration = map['duration'];
    width = map['width'];
    height = map['height'];
    file_name = map['file_name'];
    mime_type = map['mime_type'];
    has_stickers = map['has_stickers'];
    supports_streaming = map['supports_streaming'];
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
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'file_name': file_name?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
      'has_stickers': has_stickers?.toMap(skipNulls: skipNulls),
      'supports_streaming': supports_streaming?.toMap(skipNulls: skipNulls),
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

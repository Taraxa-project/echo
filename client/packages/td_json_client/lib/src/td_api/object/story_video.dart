import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/minithumbnail.dart';
import 'package:td_json_client/src/td_api/object/thumbnail.dart';
import 'package:td_json_client/src/td_api/object/file.dart';

/// Describes a video file sent in a story
class StoryVideo extends TdObject {
  String get tdType => 'storyVideo';

  /// Duration of the video, in seconds
  double? duration;

  /// Video width
  int32? width;

  /// Video height
  int32? height;

  /// True, if stickers were added to the video. The list of corresponding sticker sets can be received using getAttachedStickerSets
  Bool? has_stickers;

  /// True, if the video has no sound
  Bool? is_animation;

  /// Video minithumbnail; may be null
  Minithumbnail? minithumbnail;

  /// Video thumbnail in JPEG or MPEG4 format; may be null
  Thumbnail? thumbnail;

  /// Size of file prefix, which is supposed to be preloaded, in bytes
  int32? preload_prefix_size;

  /// File containing the video
  File? video;

  StoryVideo({
    super.extra,
    super.client_id,
    this.duration,
    this.width,
    this.height,
    this.has_stickers,
    this.is_animation,
    this.minithumbnail,
    this.thumbnail,
    this.preload_prefix_size,
    this.video,
  });

  StoryVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    duration = map['duration'];
    width = map['width'];
    height = map['height'];
    has_stickers = map['has_stickers'];
    is_animation = map['is_animation'];
    if (map['minithumbnail'] != null) {
      minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    }
    preload_prefix_size = map['preload_prefix_size'];
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
      'has_stickers': has_stickers?.toMap(skipNulls: skipNulls),
      'is_animation': is_animation?.toMap(skipNulls: skipNulls),
      'minithumbnail': minithumbnail?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'preload_prefix_size': preload_prefix_size?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

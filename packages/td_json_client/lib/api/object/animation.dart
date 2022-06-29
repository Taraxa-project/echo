import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';


/// Describes an animation file. The animation must be encoded in GIF or MPEG4 format 
class Animation extends TdObject {
  String get tdType => 'animation';

  String? extra;
  int? client_id;

  /// Duration of the animation, in seconds; as defined by the sender 
  int32? duration;

  /// Width of the animation 
  int32? width;

  /// Height of the animation
  int32? height;

  /// Original name of the file; as defined by the sender 
  string? file_name;

  /// MIME type of the file, usually "image/gif" or "video/mp4"
  string? mime_type;

  /// True, if stickers were added to the animation. The list of corresponding sticker set can be received using getAttachedStickerSets
  Bool? has_stickers;

  /// Animation minithumbnail; may be null 
  Minithumbnail? minithumbnail;

  /// Animation thumbnail in JPEG or MPEG4 format; may be null 
  Thumbnail? thumbnail;

  /// File containing the animation
  File? animation;

  Animation({
    this.extra,
    this.client_id,
    this.duration,
    this.width,
    this.height,
    this.file_name,
    this.mime_type,
    this.has_stickers,
    this.minithumbnail,
    this.thumbnail,
    this.animation,
  });

  Animation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    duration = map['duration'];
    width = map['width'];
    height = map['height'];
    file_name = map['file_name'];
    mime_type = map['mime_type'];
    has_stickers = map['has_stickers'];
    if (map['minithumbnail'] != null) {
      minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    }
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as File;
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
      'minithumbnail': minithumbnail?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

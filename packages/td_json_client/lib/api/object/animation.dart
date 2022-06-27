import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';

class Animation extends TdObject {
  String get tdType => 'animation';

  string? extra;
  int? client_id;
  int32? duration;
  int32? width;
  int32? height;
  string? file_name;
  string? mime_type;
  Bool? has_stickers;
  Minithumbnail? minithumbnail;
  Thumbnail? thumbnail;
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
    minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    animation = TdApiMap.fromMap(map['animation']) as File;
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

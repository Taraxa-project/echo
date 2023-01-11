import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/thumbnail_format.dart';
import 'package:td_json_client/api/object/file.dart';


/// Represents a thumbnail
class Thumbnail extends TdObject {
  String get tdType => 'thumbnail';


  /// Thumbnail format
  ThumbnailFormat? format;

  /// Thumbnail width
  int32? width;

  /// Thumbnail height
  int32? height;

  /// The thumbnail
  File? file;

  Thumbnail({
    super.extra,
    super.client_id,
    this.format,
    this.width,
    this.height,
    this.file,
  });

  Thumbnail.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['format'] != null) {
      format = TdApiMap.fromMap(map['format']) as ThumbnailFormat;
    }
    width = map['width'];
    height = map['height'];
    if (map['file'] != null) {
      file = TdApiMap.fromMap(map['file']) as File;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'format': format?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'file': file?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

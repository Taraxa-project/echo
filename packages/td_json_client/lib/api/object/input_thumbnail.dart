import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';


/// A thumbnail to be sent along with a file; must be in JPEG or WEBP format for stickers, and less than 200 KB in size
class InputThumbnail extends TdObject {
  String get tdType => 'inputThumbnail';

  String? extra;
  int? client_id;

  /// Thumbnail file to send. Sending thumbnails by file_id is currently not supported
  InputFile? thumbnail;

  /// Thumbnail width, usually shouldn't exceed 320. Use 0 if unknown
  int32? width;

  /// Thumbnail height, usually shouldn't exceed 320. Use 0 if unknown
  int32? height;

  InputThumbnail({
    this.extra,
    this.client_id,
    this.thumbnail,
    this.width,
    this.height,
  });

  InputThumbnail.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputFile;
    width = map['width'];
    height = map['height'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

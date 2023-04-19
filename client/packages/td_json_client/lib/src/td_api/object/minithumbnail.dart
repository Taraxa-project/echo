import 'package:td_json_client/src/td_api/td.dart';

/// Thumbnail image of a very poor quality and low resolution
class Minithumbnail extends TdObject {
  String get tdType => 'minithumbnail';

  /// Thumbnail width, usually doesn't exceed 40
  int32? width;

  /// Thumbnail height, usually doesn't exceed 40
  int32? height;

  /// The thumbnail in JPEG format
  bytes? data;

  Minithumbnail({
    super.extra,
    super.client_id,
    this.width,
    this.height,
    this.data,
  });

  Minithumbnail.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    width = map['width'];
    height = map['height'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

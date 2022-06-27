import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

class InputThumbnail extends TdObject {
  String get tdType => 'inputThumbnail';

  string? extra;
  int? client_id;
  InputFile? thumbnail;
  int32? width;
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

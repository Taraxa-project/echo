import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/location.dart';

class GetMapThumbnailFile extends TdFunction {
  String get tdType => 'getMapThumbnailFile';
  String get tdReturnType => 'File';

  string? extra;
  int? client_id;
  Location? location;
  int32? zoom;
  int32? width;
  int32? height;
  int32? scale;
  int53? chat_id;

  GetMapThumbnailFile({
    this.extra,
    this.client_id,
    this.location,
    this.zoom,
    this.width,
    this.height,
    this.scale,
    this.chat_id,
  });

  GetMapThumbnailFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    location = TdApiMap.fromMap(map['location']) as Location;
    zoom = map['zoom'];
    width = map['width'];
    height = map['height'];
    scale = map['scale'];
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'zoom': zoom?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'scale': scale?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
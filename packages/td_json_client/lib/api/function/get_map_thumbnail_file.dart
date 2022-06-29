import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/location.dart';


/// Returns information about a file with a map thumbnail in PNG format. Only map thumbnail files with size less than 1MB can be downloaded 
class GetMapThumbnailFile extends TdFunction {
  String get tdType => 'getMapThumbnailFile';
  String get tdReturnType => 'File';

  String? extra;
  int? client_id;

  /// Location of the map center 
  Location? location;

  /// Map zoom level; 13-20 
  int32? zoom;

  /// Map width in pixels before applying scale; 16-1024 
  int32? width;

  /// Map height in pixels before applying scale; 16-1024 
  int32? height;

  /// Map scale; 1-3 
  int32? scale;

  /// Identifier of a chat in which the thumbnail will be shown. Use 0 if unknown
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
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
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

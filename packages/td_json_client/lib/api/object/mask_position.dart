import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/mask_point.dart';


/// Position on a photo where a mask is placed 
class MaskPosition extends TdObject {
  String get tdType => 'maskPosition';

  String? extra;
  int? client_id;

  /// Part of the face, relative to which the mask is placed
  MaskPoint? point;

  /// Shift by X-axis measured in widths of the mask scaled to the face size, from left to right. (For example, -1.0 will place the mask just to the left of the default mask position)
  double? x_shift;

  /// Shift by Y-axis measured in heights of the mask scaled to the face size, from top to bottom. (For example, 1.0 will place the mask just below the default mask position)
  double? y_shift;

  /// Mask scaling coefficient. (For example, 2.0 means a doubled size)
  double? scale;

  MaskPosition({
    this.extra,
    this.client_id,
    this.point,
    this.x_shift,
    this.y_shift,
    this.scale,
  });

  MaskPosition.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['point'] != null) {
      point = TdApiMap.fromMap(map['point']) as MaskPoint;
    }
    x_shift = map['x_shift'];
    y_shift = map['y_shift'];
    scale = map['scale'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'point': point?.toMap(skipNulls: skipNulls),
      'x_shift': x_shift?.toMap(skipNulls: skipNulls),
      'y_shift': y_shift?.toMap(skipNulls: skipNulls),
      'scale': scale?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

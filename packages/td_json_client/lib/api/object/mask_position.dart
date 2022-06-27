import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/mask_point.dart';

class MaskPosition extends TdObject {
  String get tdType => 'maskPosition';

  String? extra;
  int? client_id;
  MaskPoint? point;
  double? x_shift;
  double? y_shift;
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
    point = TdApiMap.fromMap(map['point']) as MaskPoint;
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

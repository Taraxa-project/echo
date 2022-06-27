import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/point.dart';

abstract class VectorPathCommand extends TdObject {}

class VectorPathCommandLine extends VectorPathCommand {
  String get tdType => 'vectorPathCommandLine';

  string? extra;
  int? client_id;
  Point? end_point;

  VectorPathCommandLine({
    this.extra,
    this.client_id,
    this.end_point,
  });

  VectorPathCommandLine.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    end_point = TdApiMap.fromMap(map['end_point']) as Point;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'end_point': end_point?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class VectorPathCommandCubicBezierCurve extends VectorPathCommand {
  String get tdType => 'vectorPathCommandCubicBezierCurve';

  string? extra;
  int? client_id;
  Point? start_control_point;
  Point? end_control_point;
  Point? end_point;

  VectorPathCommandCubicBezierCurve({
    this.extra,
    this.client_id,
    this.start_control_point,
    this.end_control_point,
    this.end_point,
  });

  VectorPathCommandCubicBezierCurve.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    start_control_point = TdApiMap.fromMap(map['start_control_point']) as Point;
    end_control_point = TdApiMap.fromMap(map['end_control_point']) as Point;
    end_point = TdApiMap.fromMap(map['end_point']) as Point;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'start_control_point': start_control_point?.toMap(skipNulls: skipNulls),
      'end_control_point': end_control_point?.toMap(skipNulls: skipNulls),
      'end_point': end_point?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

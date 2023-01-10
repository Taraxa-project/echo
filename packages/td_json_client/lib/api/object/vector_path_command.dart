import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/point.dart';

/// Represents a vector path command
abstract class VectorPathCommand extends TdObject {
  VectorPathCommand({super.extra, super.client_id});
}


/// A straight line to a given point 
class VectorPathCommandLine extends VectorPathCommand {
  String get tdType => 'vectorPathCommandLine';


  /// The end point of the straight line
  Point? end_point;

  VectorPathCommandLine({
    super.extra,
    super.client_id,
    this.end_point,
  });

  VectorPathCommandLine.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['end_point'] != null) {
      end_point = TdApiMap.fromMap(map['end_point']) as Point;
    }
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

/// A cubic Bézier curve to a given point 
class VectorPathCommandCubicBezierCurve extends VectorPathCommand {
  String get tdType => 'vectorPathCommandCubicBezierCurve';


  /// The start control point of the curve 
  Point? start_control_point;

  /// The end control point of the curve 
  Point? end_control_point;

  /// The end point of the curve
  Point? end_point;

  VectorPathCommandCubicBezierCurve({
    super.extra,
    super.client_id,
    this.start_control_point,
    this.end_control_point,
    this.end_point,
  });

  VectorPathCommandCubicBezierCurve.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['start_control_point'] != null) {
      start_control_point = TdApiMap.fromMap(map['start_control_point']) as Point;
    }
    if (map['end_control_point'] != null) {
      end_control_point = TdApiMap.fromMap(map['end_control_point']) as Point;
    }
    if (map['end_point'] != null) {
      end_point = TdApiMap.fromMap(map['end_point']) as Point;
    }
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

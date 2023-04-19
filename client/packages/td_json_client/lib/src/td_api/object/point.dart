import 'package:td_json_client/src/td_api/td.dart';

/// A point on a Cartesian plane
class Point extends TdObject {
  String get tdType => 'point';

  /// The point's first coordinate
  double? x;

  /// The point's second coordinate
  double? y;

  Point({
    super.extra,
    super.client_id,
    this.x,
    this.y,
  });

  Point.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    x = map['x'];
    y = map['y'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'x': x?.toMap(skipNulls: skipNulls),
      'y': y?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
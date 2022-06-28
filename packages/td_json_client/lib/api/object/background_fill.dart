import 'package:td_json_client/api/base.dart';

/// Describes a fill of a background
abstract class BackgroundFill extends TdObject {}


/// Describes a solid fill of a background 
class BackgroundFillSolid extends BackgroundFill {
  String get tdType => 'backgroundFillSolid';

  String? extra;
  int? client_id;

  /// A color of the background in the RGB24 format
  int32? color;

  BackgroundFillSolid({
    this.extra,
    this.client_id,
    this.color,
  });

  BackgroundFillSolid.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    color = map['color'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'color': color?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Describes a gradient fill of a background 
class BackgroundFillGradient extends BackgroundFill {
  String get tdType => 'backgroundFillGradient';

  String? extra;
  int? client_id;

  /// A top color of the background in the RGB24 format 
  int32? top_color;

  /// A bottom color of the background in the RGB24 format
  int32? bottom_color;

  /// Clockwise rotation angle of the gradient, in degrees; 0-359. Must be always divisible by 45
  int32? rotation_angle;

  BackgroundFillGradient({
    this.extra,
    this.client_id,
    this.top_color,
    this.bottom_color,
    this.rotation_angle,
  });

  BackgroundFillGradient.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    top_color = map['top_color'];
    bottom_color = map['bottom_color'];
    rotation_angle = map['rotation_angle'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'top_color': top_color?.toMap(skipNulls: skipNulls),
      'bottom_color': bottom_color?.toMap(skipNulls: skipNulls),
      'rotation_angle': rotation_angle?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Describes a freeform gradient fill of a background 
class BackgroundFillFreeformGradient extends BackgroundFill {
  String get tdType => 'backgroundFillFreeformGradient';

  String? extra;
  int? client_id;

  /// A list of 3 or 4 colors of the freeform gradients in the RGB24 format
  vector<int32>? colors;

  BackgroundFillFreeformGradient({
    this.extra,
    this.client_id,
    this.colors,
  });

  BackgroundFillFreeformGradient.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['colors']) {
      colors = [];
      for (var someValue in map['colors']) {
        colors?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'colors': colors?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';

abstract class BackgroundFill extends TdObject {}

class BackgroundFillSolid extends BackgroundFill {
  String get tdType => 'backgroundFillSolid';

  String? extra;
  int? client_id;
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
class BackgroundFillGradient extends BackgroundFill {
  String get tdType => 'backgroundFillGradient';

  String? extra;
  int? client_id;
  int32? top_color;
  int32? bottom_color;
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
class BackgroundFillFreeformGradient extends BackgroundFill {
  String get tdType => 'backgroundFillFreeformGradient';

  String? extra;
  int? client_id;
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

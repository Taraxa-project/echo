import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/background_fill.dart';

abstract class BackgroundType extends TdObject {}

class BackgroundTypeWallpaper extends BackgroundType {
  String get tdType => 'backgroundTypeWallpaper';

  string? extra;
  int? client_id;
  Bool? is_blurred;
  Bool? is_moving;

  BackgroundTypeWallpaper({
    this.extra,
    this.client_id,
    this.is_blurred,
    this.is_moving,
  });

  BackgroundTypeWallpaper.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_blurred = map['is_blurred'];
    is_moving = map['is_moving'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_blurred': is_blurred?.toMap(skipNulls: skipNulls),
      'is_moving': is_moving?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class BackgroundTypePattern extends BackgroundType {
  String get tdType => 'backgroundTypePattern';

  string? extra;
  int? client_id;
  BackgroundFill? fill;
  int32? intensity;
  Bool? is_inverted;
  Bool? is_moving;

  BackgroundTypePattern({
    this.extra,
    this.client_id,
    this.fill,
    this.intensity,
    this.is_inverted,
    this.is_moving,
  });

  BackgroundTypePattern.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    fill = TdApiMap.fromMap(map['fill']) as BackgroundFill;
    intensity = map['intensity'];
    is_inverted = map['is_inverted'];
    is_moving = map['is_moving'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'fill': fill?.toMap(skipNulls: skipNulls),
      'intensity': intensity?.toMap(skipNulls: skipNulls),
      'is_inverted': is_inverted?.toMap(skipNulls: skipNulls),
      'is_moving': is_moving?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class BackgroundTypeFill extends BackgroundType {
  String get tdType => 'backgroundTypeFill';

  string? extra;
  int? client_id;
  BackgroundFill? fill;

  BackgroundTypeFill({
    this.extra,
    this.client_id,
    this.fill,
  });

  BackgroundTypeFill.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    fill = TdApiMap.fromMap(map['fill']) as BackgroundFill;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'fill': fill?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/background_fill.dart';

/// Describes the type of a background
abstract class BackgroundType extends TdObject {
  BackgroundType({super.extra, super.client_id});
}


/// A wallpaper in JPEG format
class BackgroundTypeWallpaper extends BackgroundType {
  String get tdType => 'backgroundTypeWallpaper';


  /// True, if the wallpaper must be downscaled to fit in 450x450 square and then box-blurred with radius 12
  Bool? is_blurred;

  /// True, if the background needs to be slightly moved when device is tilted
  Bool? is_moving;

  BackgroundTypeWallpaper({
    super.extra,
    super.client_id,
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

/// A PNG or TGV (gzipped subset of SVG with MIME type "application/x-tgwallpattern") pattern to be combined with the background fill chosen by the user
class BackgroundTypePattern extends BackgroundType {
  String get tdType => 'backgroundTypePattern';


  /// Fill of the background
  BackgroundFill? fill;

  /// Intensity of the pattern when it is shown above the filled background; 0-100.
  int32? intensity;

  /// True, if the background fill must be applied only to the pattern itself. All other pixels are black in this case. For dark themes only
  Bool? is_inverted;

  /// True, if the background needs to be slightly moved when device is tilted
  Bool? is_moving;

  BackgroundTypePattern({
    super.extra,
    super.client_id,
    this.fill,
    this.intensity,
    this.is_inverted,
    this.is_moving,
  });

  BackgroundTypePattern.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['fill'] != null) {
      fill = TdApiMap.fromMap(map['fill']) as BackgroundFill;
    }
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

/// A filled background 
class BackgroundTypeFill extends BackgroundType {
  String get tdType => 'backgroundTypeFill';


  /// The background fill
  BackgroundFill? fill;

  BackgroundTypeFill({
    super.extra,
    super.client_id,
    this.fill,
  });

  BackgroundTypeFill.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['fill'] != null) {
      fill = TdApiMap.fromMap(map['fill']) as BackgroundFill;
    }
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

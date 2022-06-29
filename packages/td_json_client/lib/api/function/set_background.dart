import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_background.dart';
import 'package:td_json_client/api/object/background_type.dart';


/// Changes the background selected by the user; adds background to the list of installed backgrounds
class SetBackground extends TdFunction {
  String get tdType => 'setBackground';
  String get tdReturnType => 'Background';

  String? extra;
  int? client_id;

  /// The input background to use; pass null to create a new filled backgrounds or to remove the current background
  InputBackground? background;

  /// Background type; pass null to use the default type of the remote background or to remove the current background
  BackgroundType? type;

  /// True, if the background is chosen for dark theme
  Bool? for_dark_theme;

  SetBackground({
    this.extra,
    this.client_id,
    this.background,
    this.type,
    this.for_dark_theme,
  });

  SetBackground.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['background'] != null) {
      background = TdApiMap.fromMap(map['background']) as InputBackground;
    }
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as BackgroundType;
    }
    for_dark_theme = map['for_dark_theme'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'background': background?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'for_dark_theme': for_dark_theme?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

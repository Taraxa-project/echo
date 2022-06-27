import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_background.dart';
import 'package:td_json_client/api/object/background_type.dart';

class SetBackground extends TdFunction {
  String get tdType => 'setBackground';
  String get tdReturnType => 'Background';

  String? extra;
  int? client_id;
  InputBackground? background;
  BackgroundType? type;
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
    background = TdApiMap.fromMap(map['background']) as InputBackground;
    type = TdApiMap.fromMap(map['type']) as BackgroundType;
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

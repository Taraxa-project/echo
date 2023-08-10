import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/background.dart';

/// Describes a background set for a specific chat
class ChatBackground extends TdObject {
  String get tdType => 'chatBackground';

  /// The background
  Background? background;

  /// Dimming of the background in dark themes, as a percentage; 0-100
  int32? dark_theme_dimming;

  ChatBackground({
    super.extra,
    super.client_id,
    this.background,
    this.dark_theme_dimming,
  });

  ChatBackground.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['background'] != null) {
      background = TdApiMap.fromMap(map['background']) as Background;
    }
    dark_theme_dimming = map['dark_theme_dimming'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'background': background?.toMap(skipNulls: skipNulls),
      'dark_theme_dimming': dark_theme_dimming?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

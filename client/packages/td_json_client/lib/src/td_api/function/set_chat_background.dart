import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_background.dart';
import 'package:td_json_client/src/td_api/object/background_type.dart';

/// Changes the background in a specific chat. Supported only in private and secret chats with non-deleted users
class SetChatBackground extends TdFunction {
  String get tdType => 'setChatBackground';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// The input background to use; pass null to create a new filled background or to remove the current background
  InputBackground? background;

  /// Background type; pass null to remove the current background
  BackgroundType? type;

  /// Dimming of the background in dark themes, as a percentage; 0-100
  int32? dark_theme_dimming;

  SetChatBackground({
    super.extra,
    super.client_id,
    this.chat_id,
    this.background,
    this.type,
    this.dark_theme_dimming,
  });

  SetChatBackground.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['background'] != null) {
      background = TdApiMap.fromMap(map['background']) as InputBackground;
    }
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as BackgroundType;
    }
    dark_theme_dimming = map['dark_theme_dimming'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'background': background?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'dark_theme_dimming': dark_theme_dimming?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

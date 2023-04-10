import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/background.dart';
import 'package:td_json_client/src/td_api/object/background_fill.dart';

/// Describes theme settings
class ThemeSettings extends TdObject {
  String get tdType => 'themeSettings';

  /// Theme accent color in ARGB format
  int32? accent_color;

  /// The background to be used in chats; may be null
  Background? background;

  /// The fill to be used as a background for outgoing messages
  BackgroundFill? outgoing_message_fill;

  /// If true, the freeform gradient fill needs to be animated on every sent message
  Bool? animate_outgoing_message_fill;

  /// Accent color of outgoing messages in ARGB format
  int32? outgoing_message_accent_color;

  ThemeSettings({
    super.extra,
    super.client_id,
    this.accent_color,
    this.background,
    this.outgoing_message_fill,
    this.animate_outgoing_message_fill,
    this.outgoing_message_accent_color,
  });

  ThemeSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    accent_color = map['accent_color'];
    if (map['background'] != null) {
      background = TdApiMap.fromMap(map['background']) as Background;
    }
    if (map['outgoing_message_fill'] != null) {
      outgoing_message_fill = TdApiMap.fromMap(map['outgoing_message_fill']) as BackgroundFill;
    }
    animate_outgoing_message_fill = map['animate_outgoing_message_fill'];
    outgoing_message_accent_color = map['outgoing_message_accent_color'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'accent_color': accent_color?.toMap(skipNulls: skipNulls),
      'background': background?.toMap(skipNulls: skipNulls),
      'outgoing_message_fill': outgoing_message_fill?.toMap(skipNulls: skipNulls),
      'animate_outgoing_message_fill': animate_outgoing_message_fill?.toMap(skipNulls: skipNulls),
      'outgoing_message_accent_color': outgoing_message_accent_color?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

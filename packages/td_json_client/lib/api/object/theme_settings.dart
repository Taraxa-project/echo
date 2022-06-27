import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/background.dart';
import 'package:td_json_client/api/object/background_fill.dart';

class ThemeSettings extends TdObject {
  String get tdType => 'themeSettings';

  String? extra;
  int? client_id;
  int32? accent_color;
  Background? background;
  BackgroundFill? outgoing_message_fill;
  Bool? animate_outgoing_message_fill;
  int32? outgoing_message_accent_color;

  ThemeSettings({
    this.extra,
    this.client_id,
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
    background = TdApiMap.fromMap(map['background']) as Background;
    outgoing_message_fill = TdApiMap.fromMap(map['outgoing_message_fill']) as BackgroundFill;
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

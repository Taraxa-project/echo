import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/theme_settings.dart';


/// Describes a chat theme
class ChatTheme extends TdObject {
  String get tdType => 'chatTheme';


  /// Theme name
  string? name;

  /// Theme settings for a light chat theme
  ThemeSettings? light_settings;

  /// Theme settings for a dark chat theme
  ThemeSettings? dark_settings;

  ChatTheme({
    super.extra,
    super.client_id,
    this.name,
    this.light_settings,
    this.dark_settings,
  });

  ChatTheme.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    if (map['light_settings'] != null) {
      light_settings = TdApiMap.fromMap(map['light_settings']) as ThemeSettings;
    }
    if (map['dark_settings'] != null) {
      dark_settings = TdApiMap.fromMap(map['dark_settings']) as ThemeSettings;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'light_settings': light_settings?.toMap(skipNulls: skipNulls),
      'dark_settings': dark_settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

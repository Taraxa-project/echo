import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/attachment_menu_bot_color.dart';
import 'package:td_json_client/api/object/file.dart';

class AttachmentMenuBot extends TdObject {
  String get tdType => 'attachmentMenuBot';

  String? extra;
  int? client_id;
  int53? bot_user_id;
  string? name;
  AttachmentMenuBotColor? name_color;
  File? default_icon;
  File? ios_static_icon;
  File? ios_animated_icon;
  File? android_icon;
  File? macos_icon;
  AttachmentMenuBotColor? icon_color;

  AttachmentMenuBot({
    this.extra,
    this.client_id,
    this.bot_user_id,
    this.name,
    this.name_color,
    this.default_icon,
    this.ios_static_icon,
    this.ios_animated_icon,
    this.android_icon,
    this.macos_icon,
    this.icon_color,
  });

  AttachmentMenuBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    name = map['name'];
    name_color = TdApiMap.fromMap(map['name_color']) as AttachmentMenuBotColor;
    default_icon = TdApiMap.fromMap(map['default_icon']) as File;
    ios_static_icon = TdApiMap.fromMap(map['ios_static_icon']) as File;
    ios_animated_icon = TdApiMap.fromMap(map['ios_animated_icon']) as File;
    android_icon = TdApiMap.fromMap(map['android_icon']) as File;
    macos_icon = TdApiMap.fromMap(map['macos_icon']) as File;
    icon_color = TdApiMap.fromMap(map['icon_color']) as AttachmentMenuBotColor;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'name_color': name_color?.toMap(skipNulls: skipNulls),
      'default_icon': default_icon?.toMap(skipNulls: skipNulls),
      'ios_static_icon': ios_static_icon?.toMap(skipNulls: skipNulls),
      'ios_animated_icon': ios_animated_icon?.toMap(skipNulls: skipNulls),
      'android_icon': android_icon?.toMap(skipNulls: skipNulls),
      'macos_icon': macos_icon?.toMap(skipNulls: skipNulls),
      'icon_color': icon_color?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

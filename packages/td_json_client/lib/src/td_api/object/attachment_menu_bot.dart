import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/attachment_menu_bot_color.dart';
import 'package:td_json_client/src/td_api/object/file.dart';

/// Represents a bot, which can be added to attachment menu
class AttachmentMenuBot extends TdObject {
  String get tdType => 'attachmentMenuBot';

  /// User identifier of the bot added to attachment menu
  int53? bot_user_id;

  /// True, if the bot supports opening from attachment menu in the chat with the bot
  Bool? supports_self_chat;

  /// True, if the bot supports opening from attachment menu in private chats with ordinary users
  Bool? supports_user_chats;

  /// True, if the bot supports opening from attachment menu in private chats with other bots
  Bool? supports_bot_chats;

  /// True, if the bot supports opening from attachment menu in basic group and supergroup chats
  Bool? supports_group_chats;

  /// True, if the bot supports opening from attachment menu in channel chats
  Bool? supports_channel_chats;

  /// True, if the bot supports "settings_button_pressed" event
  Bool? supports_settings;

  /// True, if the user needs to be requested to give the permission to the bot to send them messages
  Bool? request_write_access;

  /// Name for the bot in attachment menu
  string? name;

  /// Color to highlight selected name of the bot if appropriate; may be null
  AttachmentMenuBotColor? name_color;

  /// Default attachment menu icon for the bot in SVG format; may be null
  File? default_icon;

  /// Attachment menu icon for the bot in SVG format for the official iOS app; may be null
  File? ios_static_icon;

  /// Attachment menu icon for the bot in TGS format for the official iOS app; may be null
  File? ios_animated_icon;

  /// Attachment menu icon for the bot in TGS format for the official Android app; may be null
  File? android_icon;

  /// Attachment menu icon for the bot in TGS format for the official native macOS app; may be null
  File? macos_icon;

  /// Color to highlight selected icon of the bot if appropriate; may be null
  AttachmentMenuBotColor? icon_color;

  /// Default placeholder for opened Web Apps in SVG format; may be null
  File? web_app_placeholder;

  AttachmentMenuBot({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.supports_self_chat,
    this.supports_user_chats,
    this.supports_bot_chats,
    this.supports_group_chats,
    this.supports_channel_chats,
    this.supports_settings,
    this.request_write_access,
    this.name,
    this.name_color,
    this.default_icon,
    this.ios_static_icon,
    this.ios_animated_icon,
    this.android_icon,
    this.macos_icon,
    this.icon_color,
    this.web_app_placeholder,
  });

  AttachmentMenuBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    supports_self_chat = map['supports_self_chat'];
    supports_user_chats = map['supports_user_chats'];
    supports_bot_chats = map['supports_bot_chats'];
    supports_group_chats = map['supports_group_chats'];
    supports_channel_chats = map['supports_channel_chats'];
    supports_settings = map['supports_settings'];
    request_write_access = map['request_write_access'];
    name = map['name'];
    if (map['name_color'] != null) {
      name_color =
          TdApiMap.fromMap(map['name_color']) as AttachmentMenuBotColor;
    }
    if (map['default_icon'] != null) {
      default_icon = TdApiMap.fromMap(map['default_icon']) as File;
    }
    if (map['ios_static_icon'] != null) {
      ios_static_icon = TdApiMap.fromMap(map['ios_static_icon']) as File;
    }
    if (map['ios_animated_icon'] != null) {
      ios_animated_icon = TdApiMap.fromMap(map['ios_animated_icon']) as File;
    }
    if (map['android_icon'] != null) {
      android_icon = TdApiMap.fromMap(map['android_icon']) as File;
    }
    if (map['macos_icon'] != null) {
      macos_icon = TdApiMap.fromMap(map['macos_icon']) as File;
    }
    if (map['icon_color'] != null) {
      icon_color =
          TdApiMap.fromMap(map['icon_color']) as AttachmentMenuBotColor;
    }
    if (map['web_app_placeholder'] != null) {
      web_app_placeholder =
          TdApiMap.fromMap(map['web_app_placeholder']) as File;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'supports_self_chat': supports_self_chat?.toMap(skipNulls: skipNulls),
      'supports_user_chats': supports_user_chats?.toMap(skipNulls: skipNulls),
      'supports_bot_chats': supports_bot_chats?.toMap(skipNulls: skipNulls),
      'supports_group_chats': supports_group_chats?.toMap(skipNulls: skipNulls),
      'supports_channel_chats':
          supports_channel_chats?.toMap(skipNulls: skipNulls),
      'supports_settings': supports_settings?.toMap(skipNulls: skipNulls),
      'request_write_access': request_write_access?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'name_color': name_color?.toMap(skipNulls: skipNulls),
      'default_icon': default_icon?.toMap(skipNulls: skipNulls),
      'ios_static_icon': ios_static_icon?.toMap(skipNulls: skipNulls),
      'ios_animated_icon': ios_animated_icon?.toMap(skipNulls: skipNulls),
      'android_icon': android_icon?.toMap(skipNulls: skipNulls),
      'macos_icon': macos_icon?.toMap(skipNulls: skipNulls),
      'icon_color': icon_color?.toMap(skipNulls: skipNulls),
      'web_app_placeholder': web_app_placeholder?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

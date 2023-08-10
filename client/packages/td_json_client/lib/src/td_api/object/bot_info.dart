import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/photo.dart';
import 'package:td_json_client/src/td_api/object/animation.dart';
import 'package:td_json_client/src/td_api/object/bot_menu_button.dart';
import 'package:td_json_client/src/td_api/object/bot_command.dart';
import 'package:td_json_client/src/td_api/object/chat_administrator_rights.dart';
import 'package:td_json_client/src/td_api/object/internal_link_type.dart';

/// Contains information about a bot
class BotInfo extends TdObject {
  String get tdType => 'botInfo';

  /// The text that is shown on the bot's profile page and is sent together with the link when users share the bot
  string? short_description;

  string? description;

  /// Photo shown in the chat with the bot if the chat is empty; may be null
  Photo? photo;

  /// Animation shown in the chat with the bot if the chat is empty; may be null
  Animation? animation;

  /// Information about a button to show instead of the bot commands menu button; may be null if ordinary bot commands menu must be shown
  BotMenuButton? menu_button;

  /// List of the bot commands
  vector<BotCommand>? commands;

  /// Default administrator rights for adding the bot to basic group and supergroup chats; may be null
  ChatAdministratorRights? default_group_administrator_rights;

  /// Default administrator rights for adding the bot to channels; may be null
  ChatAdministratorRights? default_channel_administrator_rights;

  /// The internal link, which can be used to edit bot commands; may be null
  InternalLinkType? edit_commands_link;

  /// The internal link, which can be used to edit bot description; may be null
  InternalLinkType? edit_description_link;

  /// The internal link, which can be used to edit the photo or animation shown in the chat with the bot if the chat is empty; may be null
  InternalLinkType? edit_description_media_link;

  /// The internal link, which can be used to edit bot settings; may be null
  InternalLinkType? edit_settings_link;

  BotInfo({
    super.extra,
    super.client_id,
    this.short_description,
    this.description,
    this.photo,
    this.animation,
    this.menu_button,
    this.commands,
    this.default_group_administrator_rights,
    this.default_channel_administrator_rights,
    this.edit_commands_link,
    this.edit_description_link,
    this.edit_description_media_link,
    this.edit_settings_link,
  });

  BotInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    short_description = map['short_description'];
    description = map['description'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as Animation;
    }
    if (map['menu_button'] != null) {
      menu_button = TdApiMap.fromMap(map['menu_button']) as BotMenuButton;
    }
    if (map['commands'] != null) {
      commands = [];
      for (var someValue in map['commands']) {
        if (someValue != null) {
          commands?.add(TdApiMap.fromMap(someValue) as BotCommand);
        }
      }
    }
    if (map['default_group_administrator_rights'] != null) {
      default_group_administrator_rights = TdApiMap.fromMap(map['default_group_administrator_rights']) as ChatAdministratorRights;
    }
    if (map['default_channel_administrator_rights'] != null) {
      default_channel_administrator_rights = TdApiMap.fromMap(map['default_channel_administrator_rights']) as ChatAdministratorRights;
    }
    if (map['edit_commands_link'] != null) {
      edit_commands_link = TdApiMap.fromMap(map['edit_commands_link']) as InternalLinkType;
    }
    if (map['edit_description_link'] != null) {
      edit_description_link = TdApiMap.fromMap(map['edit_description_link']) as InternalLinkType;
    }
    if (map['edit_description_media_link'] != null) {
      edit_description_media_link = TdApiMap.fromMap(map['edit_description_media_link']) as InternalLinkType;
    }
    if (map['edit_settings_link'] != null) {
      edit_settings_link = TdApiMap.fromMap(map['edit_settings_link']) as InternalLinkType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'short_description': short_description?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
      'menu_button': menu_button?.toMap(skipNulls: skipNulls),
      'commands': commands?.toMap(skipNulls: skipNulls),
      'default_group_administrator_rights': default_group_administrator_rights?.toMap(skipNulls: skipNulls),
      'default_channel_administrator_rights': default_channel_administrator_rights?.toMap(skipNulls: skipNulls),
      'edit_commands_link': edit_commands_link?.toMap(skipNulls: skipNulls),
      'edit_description_link': edit_description_link?.toMap(skipNulls: skipNulls),
      'edit_description_media_link': edit_description_media_link?.toMap(skipNulls: skipNulls),
      'edit_settings_link': edit_settings_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

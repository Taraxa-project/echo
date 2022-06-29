import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/bot_menu_button.dart';
import 'package:td_json_client/api/object/bot_command.dart';
import 'package:td_json_client/api/object/chat_administrator_rights.dart';


/// Contains information about a bot
class BotInfo extends TdObject {
  String get tdType => 'botInfo';

  String? extra;
  int? client_id;

  /// The text that is shown on the bot's profile page and is sent together with the link when users share the bot
  string? share_text;

  string? description;

  /// Information about a button to show instead of the bot commands menu button; may be null if ordinary bot commands menu must be shown
  BotMenuButton? menu_button;

  /// List of the bot commands
  vector<BotCommand>? commands;

  /// Default administrator rights for adding the bot to basic group and supergroup chats; may be null
  ChatAdministratorRights? default_group_administrator_rights;

  /// Default administrator rights for adding the bot to channels; may be null
  ChatAdministratorRights? default_channel_administrator_rights;

  BotInfo({
    this.extra,
    this.client_id,
    this.share_text,
    this.description,
    this.menu_button,
    this.commands,
    this.default_group_administrator_rights,
    this.default_channel_administrator_rights,
  });

  BotInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    share_text = map['share_text'];
    description = map['description'];
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
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'share_text': share_text?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'menu_button': menu_button?.toMap(skipNulls: skipNulls),
      'commands': commands?.toMap(skipNulls: skipNulls),
      'default_group_administrator_rights': default_group_administrator_rights?.toMap(skipNulls: skipNulls),
      'default_channel_administrator_rights': default_channel_administrator_rights?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

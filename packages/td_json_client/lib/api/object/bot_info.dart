import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/bot_menu_button.dart';
import 'package:td_json_client/api/object/bot_command.dart';
import 'package:td_json_client/api/object/chat_administrator_rights.dart';

class BotInfo extends TdObject {
  String get tdType => 'botInfo';

  String? extra;
  int? client_id;
  string? share_text;
  string? description;
  BotMenuButton? menu_button;
  vector<BotCommand>? commands;
  ChatAdministratorRights? default_group_administrator_rights;
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
    menu_button = TdApiMap.fromMap(map['menu_button']) as BotMenuButton;
    if (map['commands']) {
      commands = [];
      for (var someValue in map['commands']) {
        commands?.add(TdApiMap.fromMap(someValue) as BotCommand);
      }
    }
    default_group_administrator_rights = TdApiMap.fromMap(map['default_group_administrator_rights']) as ChatAdministratorRights;
    default_channel_administrator_rights = TdApiMap.fromMap(map['default_channel_administrator_rights']) as ChatAdministratorRights;
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

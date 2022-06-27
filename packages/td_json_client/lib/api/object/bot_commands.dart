import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/bot_command.dart';

class BotCommands extends TdObject {
  String get tdType => 'botCommands';

  string? extra;
  int? client_id;
  int53? bot_user_id;
  vector<BotCommand>? commands;

  BotCommands({
    this.extra,
    this.client_id,
    this.bot_user_id,
    this.commands,
  });

  BotCommands.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    if (map['commands']) {
      commands = [];
      for (var someValue in map['commands']) {
        commands?.add(TdApiMap.fromMap(someValue) as BotCommand);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'commands': commands?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

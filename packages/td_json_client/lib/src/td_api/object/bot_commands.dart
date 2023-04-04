import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/bot_command.dart';

/// Contains a list of bot commands
class BotCommands extends TdObject {
  String get tdType => 'botCommands';

  /// Bot's user identifier
  int53? bot_user_id;

  /// List of bot commands
  vector<BotCommand>? commands;

  BotCommands({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.commands,
  });

  BotCommands.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    if (map['commands'] != null) {
      commands = [];
      for (var someValue in map['commands']) {
        if (someValue != null) {
          commands?.add(TdApiMap.fromMap(someValue) as BotCommand);
        }
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

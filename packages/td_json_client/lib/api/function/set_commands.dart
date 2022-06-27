import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/bot_command_scope.dart';
import 'package:td_json_client/api/object/bot_command.dart';


/// Sets the list of commands supported by the bot for the given user scope and language; for bots only
class SetCommands extends TdFunction {
  String get tdType => 'setCommands';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// The scope to which the commands are relevant; pass null to change commands in the default bot command scope
  BotCommandScope? scope;

  /// A two-letter ISO 639-1 language code. If empty, the commands will be applied to all users from the given scope, for which language there are no dedicated commands
  string? language_code;

  /// List of the bot's commands
  vector<BotCommand>? commands;

  SetCommands({
    this.extra,
    this.client_id,
    this.scope,
    this.language_code,
    this.commands,
  });

  SetCommands.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    scope = TdApiMap.fromMap(map['scope']) as BotCommandScope;
    language_code = map['language_code'];
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
      'scope': scope?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
      'commands': commands?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

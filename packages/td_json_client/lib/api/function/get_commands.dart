import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/bot_command_scope.dart';


/// Returns the list of commands supported by the bot for the given user scope and language; for bots only
class GetCommands extends TdFunction {
  String get tdType => 'getCommands';
  String get tdReturnType => 'BotCommands';

  String? extra;
  int? client_id;

  /// The scope to which the commands are relevant; pass null to get commands in the default bot command scope
  BotCommandScope? scope;

  /// A two-letter ISO 639-1 language code or an empty string
  string? language_code;

  GetCommands({
    this.extra,
    this.client_id,
    this.scope,
    this.language_code,
  });

  GetCommands.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['scope'] != null) {
      scope = TdApiMap.fromMap(map['scope']) as BotCommandScope;
    }
    language_code = map['language_code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'scope': scope?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

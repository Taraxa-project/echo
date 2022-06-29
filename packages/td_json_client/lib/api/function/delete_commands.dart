import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/bot_command_scope.dart';


/// Deletes commands supported by the bot for the given user scope and language; for bots only
class DeleteCommands extends TdFunction {
  String get tdType => 'deleteCommands';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// The scope to which the commands are relevant; pass null to delete commands in the default bot command scope
  BotCommandScope? scope;

  /// A two-letter ISO 639-1 country code or an empty string
  string? language_code;

  DeleteCommands({
    this.extra,
    this.client_id,
    this.scope,
    this.language_code,
  });

  DeleteCommands.fromMap(Map<String, dynamic> map) {
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

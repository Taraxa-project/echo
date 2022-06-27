import 'package:td_json_client/api/base.dart';


/// Represents a command supported by a bot 
class BotCommand extends TdObject {
  String get tdType => 'botCommand';

  String? extra;
  int? client_id;

  /// Text of the bot command 
  string? command;

  string? description;

  BotCommand({
    this.extra,
    this.client_id,
    this.command,
    this.description,
  });

  BotCommand.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    command = map['command'];
    description = map['description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'command': command?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

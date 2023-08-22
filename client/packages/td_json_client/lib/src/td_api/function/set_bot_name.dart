import 'package:td_json_client/src/td_api/td.dart';

/// Sets the name of a bot. Can be called only if userTypeBot.can_be_edited == true
class SetBotName extends TdFunction {
  String get tdType => 'setBotName';
  String get tdReturnType => 'Ok';

  /// Identifier of the target bot
  int53? bot_user_id;

  /// A two-letter ISO 639-1 language code. If empty, the name will be shown to all users for whose languages there is no dedicated name
  string? language_code;

  /// New bot's name on the specified language; 0-64 characters; must be non-empty if language code is empty
  string? name;

  SetBotName({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.language_code,
    this.name,
  });

  SetBotName.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    language_code = map['language_code'];
    name = map['name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

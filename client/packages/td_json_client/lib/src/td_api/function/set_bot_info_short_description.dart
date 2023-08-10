import 'package:td_json_client/src/td_api/td.dart';

/// Sets the text shown on a bot's profile page and sent together with the link when users share the bot. Can be called only if userTypeBot.can_be_edited == true
class SetBotInfoShortDescription extends TdFunction {
  String get tdType => 'setBotInfoShortDescription';
  String get tdReturnType => 'Ok';

  /// Identifier of the target bot
  int53? bot_user_id;

  /// A two-letter ISO 639-1 language code. If empty, the short description will be shown to all users for whose languages there is no dedicated description
  string? language_code;

  /// New bot's short description on the specified language
  string? short_description;

  SetBotInfoShortDescription({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.language_code,
    this.short_description,
  });

  SetBotInfoShortDescription.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    language_code = map['language_code'];
    short_description = map['short_description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
      'short_description': short_description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

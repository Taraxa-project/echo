import 'package:td_json_client/src/td_api/td.dart';

/// Returns the text shown on a bot's profile page and sent together with the link when users share the bot in the given language. Can be called only if userTypeBot.can_be_edited == true
class GetBotInfoShortDescription extends TdFunction {
  String get tdType => 'getBotInfoShortDescription';
  String get tdReturnType => 'Text';

  /// Identifier of the target bot
  int53? bot_user_id;

  /// A two-letter ISO 639-1 language code or an empty string
  string? language_code;

  GetBotInfoShortDescription({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.language_code,
  });

  GetBotInfoShortDescription.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    language_code = map['language_code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

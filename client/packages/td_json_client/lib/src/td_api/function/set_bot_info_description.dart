import 'package:td_json_client/src/td_api/td.dart';

/// Sets the text shown in the chat with a bot if the chat is empty. Can be called only if userTypeBot.can_be_edited == true
class SetBotInfoDescription extends TdFunction {
  String get tdType => 'setBotInfoDescription';
  String get tdReturnType => 'Ok';

  /// Identifier of the target bot
  int53? bot_user_id;

  /// A two-letter ISO 639-1 language code. If empty, the description will be shown to all users for whose languages there is no dedicated description
  string? language_code;

  string? description;

  SetBotInfoDescription({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.language_code,
    this.description,
  });

  SetBotInfoDescription.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    language_code = map['language_code'];
    description = map['description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'language_code': language_code?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

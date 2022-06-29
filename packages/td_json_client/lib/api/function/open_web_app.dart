import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/theme_parameters.dart';


/// Informs TDLib that a web app is being opened from attachment menu, a botMenuButton button, an internalLinkTypeAttachmentMenuBot link, or an inlineKeyboardButtonTypeWebApp button.
/// For each bot, a confirmation alert about data sent to the bot must be shown once
class OpenWebApp extends TdFunction {
  String get tdType => 'openWebApp';
  String get tdReturnType => 'WebAppInfo';

  String? extra;
  int? client_id;

  /// Identifier of the chat in which the web app is opened. Web apps can be opened only in private chats for now
  int53? chat_id;

  /// Identifier of the bot, providing the web app
  int53? bot_user_id;

  /// The URL from an inlineKeyboardButtonTypeWebApp button, a botMenuButton button, or an internalLinkTypeAttachmentMenuBot link, or an empty string otherwise
  string? url;

  /// Preferred web app theme; pass null to use the default theme
  ThemeParameters? theme;

  /// Identifier of the replied message for the message sent by the web app; 0 if none
  int53? reply_to_message_id;

  OpenWebApp({
    this.extra,
    this.client_id,
    this.chat_id,
    this.bot_user_id,
    this.url,
    this.theme,
    this.reply_to_message_id,
  });

  OpenWebApp.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    bot_user_id = map['bot_user_id'];
    url = map['url'];
    if (map['theme'] != null) {
      theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
    }
    reply_to_message_id = map['reply_to_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'theme': theme?.toMap(skipNulls: skipNulls),
      'reply_to_message_id': reply_to_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

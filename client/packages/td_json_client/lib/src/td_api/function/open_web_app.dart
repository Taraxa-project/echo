import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/theme_parameters.dart';
import 'package:td_json_client/src/td_api/object/message_reply_to.dart';

/// Informs TDLib that a Web App is being opened from attachment menu, a botMenuButton button, an internalLinkTypeAttachmentMenuBot link, or an inlineKeyboardButtonTypeWebApp button.
/// For each bot, a confirmation alert about data sent to the bot must be shown once
class OpenWebApp extends TdFunction {
  String get tdType => 'openWebApp';
  String get tdReturnType => 'WebAppInfo';

  /// Identifier of the chat in which the Web App is opened. The Web App can't be opened in secret chats
  int53? chat_id;

  /// Identifier of the bot, providing the Web App
  int53? bot_user_id;

  /// The URL from an inlineKeyboardButtonTypeWebApp button, a botMenuButton button, or an internalLinkTypeAttachmentMenuBot link, or an empty string otherwise
  string? url;

  /// Preferred Web App theme; pass null to use the default theme
  ThemeParameters? theme;

  /// Short name of the application; 0-64 English letters, digits, and underscores
  string? application_name;

  /// If not 0, a message thread identifier in which the message will be sent
  int53? message_thread_id;

  /// Identifier of the replied message or story for the message sent by the Web App; pass null if none
  MessageReplyTo? reply_to;

  OpenWebApp({
    super.extra,
    super.client_id,
    this.chat_id,
    this.bot_user_id,
    this.url,
    this.theme,
    this.application_name,
    this.message_thread_id,
    this.reply_to,
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
    application_name = map['application_name'];
    message_thread_id = map['message_thread_id'];
    if (map['reply_to'] != null) {
      reply_to = TdApiMap.fromMap(map['reply_to']) as MessageReplyTo;
    }
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
      'application_name': application_name?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'reply_to': reply_to?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

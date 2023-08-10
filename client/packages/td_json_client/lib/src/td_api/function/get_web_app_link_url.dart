import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/theme_parameters.dart';

/// Returns an HTTPS URL of a Web App to open after a link of the type internalLinkTypeWebApp is clicked
class GetWebAppLinkUrl extends TdFunction {
  String get tdType => 'getWebAppLinkUrl';
  String get tdReturnType => 'HttpUrl';

  /// Identifier of the chat in which the link was clicked; pass 0 if none
  int53? chat_id;

  /// Identifier of the target bot
  int53? bot_user_id;

  /// Short name of the Web App
  string? web_app_short_name;

  /// Start parameter from internalLinkTypeWebApp
  string? start_parameter;

  /// Preferred Web App theme; pass null to use the default theme
  ThemeParameters? theme;

  /// Short name of the application; 0-64 English letters, digits, and underscores
  string? application_name;

  /// Pass true if the current user allowed the bot to send them messages
  Bool? allow_write_access;

  GetWebAppLinkUrl({
    super.extra,
    super.client_id,
    this.chat_id,
    this.bot_user_id,
    this.web_app_short_name,
    this.start_parameter,
    this.theme,
    this.application_name,
    this.allow_write_access,
  });

  GetWebAppLinkUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    bot_user_id = map['bot_user_id'];
    web_app_short_name = map['web_app_short_name'];
    start_parameter = map['start_parameter'];
    if (map['theme'] != null) {
      theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
    }
    application_name = map['application_name'];
    allow_write_access = map['allow_write_access'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'web_app_short_name': web_app_short_name?.toMap(skipNulls: skipNulls),
      'start_parameter': start_parameter?.toMap(skipNulls: skipNulls),
      'theme': theme?.toMap(skipNulls: skipNulls),
      'application_name': application_name?.toMap(skipNulls: skipNulls),
      'allow_write_access': allow_write_access?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

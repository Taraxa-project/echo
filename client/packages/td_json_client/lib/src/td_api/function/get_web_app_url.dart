import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/theme_parameters.dart';

/// Returns an HTTPS URL of a Web App to open after keyboardButtonTypeWebApp button is pressed
class GetWebAppUrl extends TdFunction {
  String get tdType => 'getWebAppUrl';
  String get tdReturnType => 'HttpUrl';

  /// Identifier of the target bot
  int53? bot_user_id;

  /// The URL from the keyboardButtonTypeWebApp button
  string? url;

  /// Preferred Web App theme; pass null to use the default theme
  ThemeParameters? theme;

  /// Short name of the application; 0-64 English letters, digits, and underscores
  string? application_name;

  GetWebAppUrl({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.url,
    this.theme,
    this.application_name,
  });

  GetWebAppUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    url = map['url'];
    if (map['theme'] != null) {
      theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
    }
    application_name = map['application_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'theme': theme?.toMap(skipNulls: skipNulls),
      'application_name': application_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

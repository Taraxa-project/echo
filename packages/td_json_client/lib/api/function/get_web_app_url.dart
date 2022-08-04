import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/theme_parameters.dart';


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

  GetWebAppUrl({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.url,
    this.theme,
  });

  GetWebAppUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    url = map['url'];
    if (map['theme'] != null) {
      theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'theme': theme?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

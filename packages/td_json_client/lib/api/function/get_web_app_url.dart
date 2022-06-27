import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/theme_parameters.dart';

class GetWebAppUrl extends TdFunction {
  String get tdType => 'getWebAppUrl';
  String get tdReturnType => 'HttpUrl';

  String? extra;
  int? client_id;
  int53? bot_user_id;
  string? url;
  ThemeParameters? theme;

  GetWebAppUrl({
    this.extra,
    this.client_id,
    this.bot_user_id,
    this.url,
    this.theme,
  });

  GetWebAppUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    url = map['url'];
    theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
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

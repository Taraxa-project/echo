import 'package:td_json_client/src/td_api/td.dart';

/// Returns information about a Web App by its short name. Returns a 404 error if the Web App is not found
class SearchWebApp extends TdFunction {
  String get tdType => 'searchWebApp';
  String get tdReturnType => 'FoundWebApp';

  /// Identifier of the target bot
  int53? bot_user_id;

  /// Short name of the Web App
  string? web_app_short_name;

  SearchWebApp({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.web_app_short_name,
  });

  SearchWebApp.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    web_app_short_name = map['web_app_short_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'web_app_short_name': web_app_short_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

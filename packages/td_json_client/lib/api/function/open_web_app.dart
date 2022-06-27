import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/theme_parameters.dart';

class OpenWebApp extends TdFunction {
  String get tdType => 'openWebApp';
  String get tdReturnType => 'WebAppInfo';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? bot_user_id;
  string? url;
  ThemeParameters? theme;
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
    theme = TdApiMap.fromMap(map['theme']) as ThemeParameters;
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

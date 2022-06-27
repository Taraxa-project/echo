import 'package:td_json_client/api/base.dart';


/// Changes the chat theme. Supported only in private and secret chats 
class SetChatTheme extends TdFunction {
  String get tdType => 'setChatTheme';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Name of the new chat theme; pass an empty string to return the default theme
  string? theme_name;

  SetChatTheme({
    this.extra,
    this.client_id,
    this.chat_id,
    this.theme_name,
  });

  SetChatTheme.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    theme_name = map['theme_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'theme_name': theme_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

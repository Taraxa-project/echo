import 'package:td_json_client/api/base.dart';


/// Sends data received from a keyboardButtonTypeWebApp Web App to a bot
class SendWebAppData extends TdFunction {
  String get tdType => 'sendWebAppData';
  String get tdReturnType => 'Ok';


  /// Identifier of the target bot
  int53? bot_user_id;

  /// Text of the keyboardButtonTypeWebApp button, which opened the Web App
  string? button_text;

  /// Received data
  string? data;

  SendWebAppData({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.button_text,
    this.data,
  });

  SendWebAppData.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    button_text = map['button_text'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'button_text': button_text?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

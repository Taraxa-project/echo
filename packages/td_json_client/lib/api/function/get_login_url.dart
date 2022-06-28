import 'package:td_json_client/api/base.dart';


/// Returns an HTTP URL which can be used to automatically authorize the user on a website after clicking an inline button of type inlineKeyboardButtonTypeLoginUrl.
/// Use the method getLoginUrlInfo to find whether a prior user confirmation is needed. If an error is returned, then the button must be handled as an ordinary URL button
class GetLoginUrl extends TdFunction {
  String get tdType => 'getLoginUrl';
  String get tdReturnType => 'HttpUrl';

  String? extra;
  int? client_id;

  /// Chat identifier of the message with the button 
  int53? chat_id;

  /// Message identifier of the message with the button 
  int53? message_id;

  /// Button identifier
  int53? button_id;

  /// Pass true to allow the bot to send messages to the current user
  Bool? allow_write_access;

  GetLoginUrl({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.button_id,
    this.allow_write_access,
  });

  GetLoginUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    button_id = map['button_id'];
    allow_write_access = map['allow_write_access'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'button_id': button_id?.toMap(skipNulls: skipNulls),
      'allow_write_access': allow_write_access?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Informs TDLib that the user opened the sponsored chat via the button, the name, the photo, or a mention in the sponsored message
class ClickChatSponsoredMessage extends TdFunction {
  String get tdType => 'clickChatSponsoredMessage';
  String get tdReturnType => 'Ok';

  /// Chat identifier of the sponsored message
  int53? chat_id;

  /// Identifier of the sponsored message
  int53? message_id;

  ClickChatSponsoredMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  ClickChatSponsoredMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

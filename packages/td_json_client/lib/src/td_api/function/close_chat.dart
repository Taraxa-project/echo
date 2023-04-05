import 'package:td_json_client/src/td_api/td.dart';

/// Informs TDLib that the chat is closed by the user. Many useful activities depend on the chat being opened or closed
class CloseChat extends TdFunction {
  String get tdType => 'closeChat';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  CloseChat({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  CloseChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

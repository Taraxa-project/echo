import 'package:td_json_client/api/base.dart';


/// Informs TDLib that the chat is opened by the user. Many useful activities depend on the chat being opened or closed (e.g., in supergroups and channels all updates are received only for opened chats) 
class OpenChat extends TdFunction {
  String get tdType => 'openChat';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  OpenChat({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  OpenChat.fromMap(Map<String, dynamic> map) {
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

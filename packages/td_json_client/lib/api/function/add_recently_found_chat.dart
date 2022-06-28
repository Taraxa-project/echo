import 'package:td_json_client/api/base.dart';


/// Adds a chat to the list of recently found chats. The chat is added to the beginning of the list. If the chat is already in the list, it will be removed from the list first 
class AddRecentlyFoundChat extends TdFunction {
  String get tdType => 'addRecentlyFoundChat';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Identifier of the chat to add
  int53? chat_id;

  AddRecentlyFoundChat({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  AddRecentlyFoundChat.fromMap(Map<String, dynamic> map) {
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

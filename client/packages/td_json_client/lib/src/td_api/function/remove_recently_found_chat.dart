import 'package:td_json_client/src/td_api/td.dart';

/// Removes a chat from the list of recently found chats
class RemoveRecentlyFoundChat extends TdFunction {
  String get tdType => 'removeRecentlyFoundChat';
  String get tdReturnType => 'Ok';

  /// Identifier of the chat to be removed
  int53? chat_id;

  RemoveRecentlyFoundChat({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  RemoveRecentlyFoundChat.fromMap(Map<String, dynamic> map) {
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

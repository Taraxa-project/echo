import 'package:td_json_client/src/td_api/td.dart';

/// Returns a list of administrators of the chat with their custom titles
class GetChatAdministrators extends TdFunction {
  String get tdType => 'getChatAdministrators';
  String get tdReturnType => 'ChatAdministrators';

  /// Chat identifier
  int53? chat_id;

  GetChatAdministrators({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  GetChatAdministrators.fromMap(Map<String, dynamic> map) {
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

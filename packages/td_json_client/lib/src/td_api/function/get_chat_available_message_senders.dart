import 'package:td_json_client/src/td_api/td.dart';

/// Returns list of message sender identifiers, which can be used to send messages in a chat
class GetChatAvailableMessageSenders extends TdFunction {
  String get tdType => 'getChatAvailableMessageSenders';
  String get tdReturnType => 'ChatMessageSenders';

  /// Chat identifier
  int53? chat_id;

  GetChatAvailableMessageSenders({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  GetChatAvailableMessageSenders.fromMap(Map<String, dynamic> map) {
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

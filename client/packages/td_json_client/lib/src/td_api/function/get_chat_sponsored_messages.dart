import 'package:td_json_client/src/td_api/td.dart';

/// Returns sponsored messages to be shown in a chat; for channel chats only
class GetChatSponsoredMessages extends TdFunction {
  String get tdType => 'getChatSponsoredMessages';
  String get tdReturnType => 'SponsoredMessages';

  /// Identifier of the chat
  int53? chat_id;

  GetChatSponsoredMessages({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  GetChatSponsoredMessages.fromMap(Map<String, dynamic> map) {
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

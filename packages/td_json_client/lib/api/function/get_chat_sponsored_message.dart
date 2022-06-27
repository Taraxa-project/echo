import 'package:td_json_client/api/base.dart';


/// Returns sponsored message to be shown in a chat; for channel chats only. Returns a 404 error if there is no sponsored message in the chat 
class GetChatSponsoredMessage extends TdFunction {
  String get tdType => 'getChatSponsoredMessage';
  String get tdReturnType => 'SponsoredMessage';

  String? extra;
  int? client_id;

  /// Identifier of the chat
  int53? chat_id;

  GetChatSponsoredMessage({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  GetChatSponsoredMessage.fromMap(Map<String, dynamic> map) {
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

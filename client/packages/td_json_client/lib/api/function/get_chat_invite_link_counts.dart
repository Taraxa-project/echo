import 'package:td_json_client/api/base.dart';


/// Returns list of chat administrators with number of their invite links. Requires owner privileges in the chat 
class GetChatInviteLinkCounts extends TdFunction {
  String get tdType => 'getChatInviteLinkCounts';
  String get tdReturnType => 'ChatInviteLinkCounts';


  /// Chat identifier
  int53? chat_id;

  GetChatInviteLinkCounts({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  GetChatInviteLinkCounts.fromMap(Map<String, dynamic> map) {
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

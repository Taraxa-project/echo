import 'package:td_json_client/api/base.dart';


/// Deletes all messages in the chat. Use chat.can_be_deleted_only_for_self and chat.can_be_deleted_for_all_users fields to find whether and how the method can be applied to the chat
class DeleteChatHistory extends TdFunction {
  String get tdType => 'deleteChatHistory';
  String get tdReturnType => 'Ok';


  /// Chat identifier 
  int53? chat_id;

  /// Pass true to remove the chat from all chat lists 
  Bool? remove_from_chat_list;

  /// Pass true to delete chat history for all users
  Bool? revoke;

  DeleteChatHistory({
    super.extra,
    super.client_id,
    this.chat_id,
    this.remove_from_chat_list,
    this.revoke,
  });

  DeleteChatHistory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    remove_from_chat_list = map['remove_from_chat_list'];
    revoke = map['revoke'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'remove_from_chat_list': remove_from_chat_list?.toMap(skipNulls: skipNulls),
      'revoke': revoke?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';

/// Deletes a chat along with all messages in the corresponding chat for all chat members. For group chats this will release the usernames and remove all members.
/// Use the field chat.can_be_deleted_for_all_users to find whether the method can be applied to the chat
class DeleteChat extends TdFunction {
  String get tdType => 'deleteChat';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  DeleteChat({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  DeleteChat.fromMap(Map<String, dynamic> map) {
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

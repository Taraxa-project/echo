import 'package:td_json_client/src/td_api/td.dart';

/// Adds a new member to a chat. Members can't be added to private or secret chats
class AddChatMember extends TdFunction {
  String get tdType => 'addChatMember';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// Identifier of the user
  int53? user_id;

  /// The number of earlier messages from the chat to be forwarded to the new member; up to 100. Ignored for supergroups and channels, or if the added user is a bot
  int32? forward_limit;

  AddChatMember({
    super.extra,
    super.client_id,
    this.chat_id,
    this.user_id,
    this.forward_limit,
  });

  AddChatMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    user_id = map['user_id'];
    forward_limit = map['forward_limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'forward_limit': forward_limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

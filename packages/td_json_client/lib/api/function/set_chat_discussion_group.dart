import 'package:td_json_client/api/base.dart';


/// Changes the discussion group of a channel chat; requires can_change_info administrator right in the channel if it is specified
class SetChatDiscussionGroup extends TdFunction {
  String get tdType => 'setChatDiscussionGroup';
  String get tdReturnType => 'Ok';


  /// Identifier of the channel chat. Pass 0 to remove a link from the supergroup passed in the second argument to a linked channel chat (requires can_pin_messages rights in the supergroup)
  int53? chat_id;

  /// Identifier of a new channel's discussion group. Use 0 to remove the discussion group. Use the method getSuitableDiscussionChats to find all suitable groups.
  /// Basic group chats must be first upgraded to supergroup chats. If new chat members don't have access to old messages in the supergroup, then toggleSupergroupIsAllHistoryAvailable must be used first to change that
  int53? discussion_chat_id;

  SetChatDiscussionGroup({
    super.extra,
    super.client_id,
    this.chat_id,
    this.discussion_chat_id,
  });

  SetChatDiscussionGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    discussion_chat_id = map['discussion_chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'discussion_chat_id': discussion_chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

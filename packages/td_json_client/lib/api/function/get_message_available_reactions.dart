import 'package:td_json_client/api/base.dart';


/// Returns reactions, which can be added to a message. The list can change after updateReactions, updateChatAvailableReactions for the chat, or updateMessageInteractionInfo for the message. The method will return Premium reactions, even the current user has no Premium subscription
class GetMessageAvailableReactions extends TdFunction {
  String get tdType => 'getMessageAvailableReactions';
  String get tdReturnType => 'AvailableReactions';


  /// Identifier of the chat to which the message belongs
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  GetMessageAvailableReactions({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  GetMessageAvailableReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

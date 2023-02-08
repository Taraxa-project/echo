import 'package:td_json_client/api/base.dart';

/// Returns information about a message that is replied by a given message. Also, returns the pinned message, the game message, the invoice message, and the topic creation message for messages
/// of the types messagePinMessage, messageGameScore, messagePaymentSuccessful, and topic messages without replied message respectively
class GetRepliedMessage extends TdFunction {
  String get tdType => 'getRepliedMessage';
  String get tdReturnType => 'Message';

  /// Identifier of the chat the message belongs to
  int53? chat_id;

  /// Identifier of the reply message
  int53? message_id;

  GetRepliedMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  GetRepliedMessage.fromMap(Map<String, dynamic> map) {
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

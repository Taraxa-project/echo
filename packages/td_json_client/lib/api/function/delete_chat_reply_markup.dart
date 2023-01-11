import 'package:td_json_client/api/base.dart';


/// Deletes the default reply markup from a chat. Must be called after a one-time keyboard or a replyMarkupForceReply reply markup has been used. An updateChatReplyMarkup update will be sent if the reply markup is changed
class DeleteChatReplyMarkup extends TdFunction {
  String get tdType => 'deleteChatReplyMarkup';
  String get tdReturnType => 'Ok';


  /// Chat identifier
  int53? chat_id;

  /// The message identifier of the used keyboard
  int53? message_id;

  DeleteChatReplyMarkup({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
  });

  DeleteChatReplyMarkup.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/api/base.dart';


/// Resends messages which failed to send. Can be called only for messages for which messageSendingStateFailed.can_retry is true and after specified in messageSendingStateFailed.retry_after time passed.
/// If a message is re-sent, the corresponding failed to send message is deleted. Returns the sent messages in the same order as the message identifiers passed in message_ids. If a message can't be re-sent, null will be returned instead of the message
class ResendMessages extends TdFunction {
  String get tdType => 'resendMessages';
  String get tdReturnType => 'Messages';

  String? extra;
  int? client_id;

  /// Identifier of the chat to send messages 
  int53? chat_id;

  /// Identifiers of the messages to resend. Message identifiers must be in a strictly increasing order
  vector<int53>? message_ids;

  ResendMessages({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_ids,
  });

  ResendMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_ids'] != null) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

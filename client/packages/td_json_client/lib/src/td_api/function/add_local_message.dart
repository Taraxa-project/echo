import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';
import 'package:td_json_client/src/td_api/object/message_reply_to.dart';
import 'package:td_json_client/src/td_api/object/input_message_content.dart';

/// Adds a local message to a chat. The message is persistent across application restarts only if the message database is used. Returns the added message
class AddLocalMessage extends TdFunction {
  String get tdType => 'addLocalMessage';
  String get tdReturnType => 'Message';

  /// Target chat
  int53? chat_id;

  /// Identifier of the sender of the message
  MessageSender? sender_id;

  /// Identifier of the replied message or story; pass null if none
  MessageReplyTo? reply_to;

  /// Pass true to disable notification for the message
  Bool? disable_notification;

  /// The content of the message to be added
  InputMessageContent? input_message_content;

  AddLocalMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.sender_id,
    this.reply_to,
    this.disable_notification,
    this.input_message_content,
  });

  AddLocalMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['sender_id'] != null) {
      sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    }
    if (map['reply_to'] != null) {
      reply_to = TdApiMap.fromMap(map['reply_to']) as MessageReplyTo;
    }
    disable_notification = map['disable_notification'];
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
      'reply_to': reply_to?.toMap(skipNulls: skipNulls),
      'disable_notification': disable_notification?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

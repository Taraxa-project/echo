import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_send_options.dart';
import 'package:td_json_client/src/td_api/object/reply_markup.dart';
import 'package:td_json_client/src/td_api/object/input_message_content.dart';

/// Sends a message. Returns the sent message
class SendMessage extends TdFunction {
  String get tdType => 'sendMessage';
  String get tdReturnType => 'Message';

  /// Target chat
  int53? chat_id;

  /// If not 0, a message thread identifier in which the message will be sent
  int53? message_thread_id;

  /// Identifier of the replied message; 0 if none
  int53? reply_to_message_id;

  /// Options to be used to send the message; pass null to use default options
  MessageSendOptions? options;

  /// Markup for replying to the message; pass null if none; for bots only
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent
  InputMessageContent? input_message_content;

  SendMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.reply_to_message_id,
    this.options,
    this.reply_markup,
    this.input_message_content,
  });

  SendMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    reply_to_message_id = map['reply_to_message_id'];
    if (map['options'] != null) {
      options = TdApiMap.fromMap(map['options']) as MessageSendOptions;
    }
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
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
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'reply_to_message_id': reply_to_message_id?.toMap(skipNulls: skipNulls),
      'options': options?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

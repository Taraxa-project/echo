import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_reply_to.dart';
import 'package:td_json_client/src/td_api/object/message_send_options.dart';

/// Sends the result of an inline query as a message. Returns the sent message. Always clears a chat draft message
class SendInlineQueryResultMessage extends TdFunction {
  String get tdType => 'sendInlineQueryResultMessage';
  String get tdReturnType => 'Message';

  /// Target chat
  int53? chat_id;

  /// If not 0, a message thread identifier in which the message will be sent
  int53? message_thread_id;

  /// Identifier of the replied message or story; pass null if none
  MessageReplyTo? reply_to;

  /// Options to be used to send the message; pass null to use default options
  MessageSendOptions? options;

  /// Identifier of the inline query
  int64? query_id;

  /// Identifier of the inline result
  string? result_id;

  /// Pass true to hide the bot, via which the message is sent. Can be used only for bots getOption("animation_search_bot_username"), getOption("photo_search_bot_username"), and getOption("venue_search_bot_username")
  Bool? hide_via_bot;

  SendInlineQueryResultMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.reply_to,
    this.options,
    this.query_id,
    this.result_id,
    this.hide_via_bot,
  });

  SendInlineQueryResultMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    if (map['reply_to'] != null) {
      reply_to = TdApiMap.fromMap(map['reply_to']) as MessageReplyTo;
    }
    if (map['options'] != null) {
      options = TdApiMap.fromMap(map['options']) as MessageSendOptions;
    }
    query_id = map['query_id'];
    result_id = map['result_id'];
    hide_via_bot = map['hide_via_bot'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'reply_to': reply_to?.toMap(skipNulls: skipNulls),
      'options': options?.toMap(skipNulls: skipNulls),
      'query_id': query_id?.toMap(skipNulls: skipNulls),
      'result_id': result_id?.toMap(skipNulls: skipNulls),
      'hide_via_bot': hide_via_bot?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

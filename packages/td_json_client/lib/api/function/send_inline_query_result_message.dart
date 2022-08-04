import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_send_options.dart';


/// Sends the result of an inline query as a message. Returns the sent message. Always clears a chat draft message
class SendInlineQueryResultMessage extends TdFunction {
  String get tdType => 'sendInlineQueryResultMessage';
  String get tdReturnType => 'Message';


  /// Target chat
  int53? chat_id;

  /// If not 0, a message thread identifier in which the message will be sent
  int53? message_thread_id;

  /// Identifier of a replied message; 0 if none
  int53? reply_to_message_id;

  /// Options to be used to send the message; pass null to use default options
  MessageSendOptions? options;

  /// Identifier of the inline query
  int64? query_id;

  /// Identifier of the inline result
  string? result_id;

  /// Pass true to hide the bot, via which the message is sent. Can be used only for bots GetOption("animation_search_bot_username"), GetOption("photo_search_bot_username"), and GetOption("venue_search_bot_username")
  Bool? hide_via_bot;

  SendInlineQueryResultMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.reply_to_message_id,
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
    reply_to_message_id = map['reply_to_message_id'];
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
      'reply_to_message_id': reply_to_message_id?.toMap(skipNulls: skipNulls),
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

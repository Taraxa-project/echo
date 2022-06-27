import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_send_options.dart';

class SendInlineQueryResultMessage extends TdFunction {
  String get tdType => 'sendInlineQueryResultMessage';
  String get tdReturnType => 'Message';

  String? extra;
  int? client_id;
  int53? chat_id;
  int53? message_thread_id;
  int53? reply_to_message_id;
  MessageSendOptions? options;
  int64? query_id;
  string? result_id;
  Bool? hide_via_bot;

  SendInlineQueryResultMessage({
    this.extra,
    this.client_id,
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
    options = TdApiMap.fromMap(map['options']) as MessageSendOptions;
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

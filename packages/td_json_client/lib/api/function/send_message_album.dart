import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_send_options.dart';
import 'package:td_json_client/api/object/input_message_content.dart';

class SendMessageAlbum extends TdFunction {
  String get tdType => 'sendMessageAlbum';
  String get tdReturnType => 'Messages';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_thread_id;
  int53? reply_to_message_id;
  MessageSendOptions? options;
  vector<InputMessageContent>? input_message_contents;

  SendMessageAlbum({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_thread_id,
    this.reply_to_message_id,
    this.options,
    this.input_message_contents,
  });

  SendMessageAlbum.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    reply_to_message_id = map['reply_to_message_id'];
    options = TdApiMap.fromMap(map['options']) as MessageSendOptions;
    if (map['input_message_contents']) {
      input_message_contents = [];
      for (var someValue in map['input_message_contents']) {
        input_message_contents?.add(TdApiMap.fromMap(someValue) as InputMessageContent);
      }
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
      'input_message_contents': input_message_contents?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

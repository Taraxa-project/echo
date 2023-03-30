import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_send_options.dart';
import 'package:td_json_client/src/td_api/object/input_message_content.dart';

/// Sends 2-10 messages grouped together into an album. Currently, only audio, document, photo and video messages can be grouped into an album. Documents and audio files can be only grouped in an album with messages of the same type. Returns sent messages
class SendMessageAlbum extends TdFunction {
  String get tdType => 'sendMessageAlbum';
  String get tdReturnType => 'Messages';

  /// Target chat
  int53? chat_id;

  /// If not 0, a message thread identifier in which the messages will be sent
  int53? message_thread_id;

  /// Identifier of a replied message; 0 if none
  int53? reply_to_message_id;

  /// Options to be used to send the messages; pass null to use default options
  MessageSendOptions? options;

  /// Contents of messages to be sent. At most 10 messages can be added to an album
  vector<InputMessageContent>? input_message_contents;

  /// Pass true to get fake messages instead of actually sending them
  Bool? only_preview;

  SendMessageAlbum({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.reply_to_message_id,
    this.options,
    this.input_message_contents,
    this.only_preview,
  });

  SendMessageAlbum.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    reply_to_message_id = map['reply_to_message_id'];
    if (map['options'] != null) {
      options = TdApiMap.fromMap(map['options']) as MessageSendOptions;
    }
    if (map['input_message_contents'] != null) {
      input_message_contents = [];
      for (var someValue in map['input_message_contents']) {
        if (someValue != null) {
          input_message_contents
              ?.add(TdApiMap.fromMap(someValue) as InputMessageContent);
        }
      }
    }
    only_preview = map['only_preview'];
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
      'input_message_contents':
          input_message_contents?.toMap(skipNulls: skipNulls),
      'only_preview': only_preview?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

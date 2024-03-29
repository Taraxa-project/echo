import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_send_options.dart';

/// Forwards previously sent messages. Returns the forwarded messages in the same order as the message identifiers passed in message_ids. If a message can't be forwarded, null will be returned instead of the message
class ForwardMessages extends TdFunction {
  String get tdType => 'forwardMessages';
  String get tdReturnType => 'Messages';

  /// Identifier of the chat to which to forward messages
  int53? chat_id;

  /// If not 0, a message thread identifier in which the message will be sent; for forum threads only
  int53? message_thread_id;

  /// Identifier of the chat from which to forward messages
  int53? from_chat_id;

  /// Identifiers of the messages to forward. Message identifiers must be in a strictly increasing order. At most 100 messages can be forwarded simultaneously
  vector<int53>? message_ids;

  /// Options to be used to send the messages; pass null to use default options
  MessageSendOptions? options;

  /// Pass true to copy content of the messages without reference to the original sender. Always true if the messages are forwarded to a secret chat or are local
  Bool? send_copy;

  /// Pass true to remove media captions of message copies. Ignored if send_copy is false
  Bool? remove_caption;

  /// Pass true to get fake messages instead of actually forwarding them
  Bool? only_preview;

  ForwardMessages({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.from_chat_id,
    this.message_ids,
    this.options,
    this.send_copy,
    this.remove_caption,
    this.only_preview,
  });

  ForwardMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    from_chat_id = map['from_chat_id'];
    if (map['message_ids'] != null) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
    if (map['options'] != null) {
      options = TdApiMap.fromMap(map['options']) as MessageSendOptions;
    }
    send_copy = map['send_copy'];
    remove_caption = map['remove_caption'];
    only_preview = map['only_preview'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'from_chat_id': from_chat_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
      'options': options?.toMap(skipNulls: skipNulls),
      'send_copy': send_copy?.toMap(skipNulls: skipNulls),
      'remove_caption': remove_caption?.toMap(skipNulls: skipNulls),
      'only_preview': only_preview?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

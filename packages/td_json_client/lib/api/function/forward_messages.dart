import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_send_options.dart';

class ForwardMessages extends TdFunction {
  String get tdType => 'forwardMessages';
  String get tdReturnType => 'Messages';

  String? extra;
  int? client_id;
  int53? chat_id;
  int53? from_chat_id;
  vector<int53>? message_ids;
  MessageSendOptions? options;
  Bool? send_copy;
  Bool? remove_caption;
  Bool? only_preview;

  ForwardMessages({
    this.extra,
    this.client_id,
    this.chat_id,
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
    from_chat_id = map['from_chat_id'];
    if (map['message_ids']) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
    options = TdApiMap.fromMap(map['options']) as MessageSendOptions;
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

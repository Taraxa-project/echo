import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/input_message_content.dart';

class AddLocalMessage extends TdFunction {
  String get tdType => 'addLocalMessage';
  String get tdReturnType => 'Message';

  String? extra;
  int? client_id;
  int53? chat_id;
  MessageSender? sender_id;
  int53? reply_to_message_id;
  Bool? disable_notification;
  InputMessageContent? input_message_content;

  AddLocalMessage({
    this.extra,
    this.client_id,
    this.chat_id,
    this.sender_id,
    this.reply_to_message_id,
    this.disable_notification,
    this.input_message_content,
  });

  AddLocalMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    reply_to_message_id = map['reply_to_message_id'];
    disable_notification = map['disable_notification'];
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
      'reply_to_message_id': reply_to_message_id?.toMap(skipNulls: skipNulls),
      'disable_notification': disable_notification?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

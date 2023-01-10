import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';


/// Selects a message sender to send messages in a chat 
class SetChatMessageSender extends TdFunction {
  String get tdType => 'setChatMessageSender';
  String get tdReturnType => 'Ok';


  /// Chat identifier 
  int53? chat_id;

  /// New message sender for the chat
  MessageSender? message_sender_id;

  SetChatMessageSender({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_sender_id,
  });

  SetChatMessageSender.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_sender_id'] != null) {
      message_sender_id = TdApiMap.fromMap(map['message_sender_id']) as MessageSender;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_sender_id': message_sender_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

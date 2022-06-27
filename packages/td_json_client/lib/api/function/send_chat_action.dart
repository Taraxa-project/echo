import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_action.dart';

class SendChatAction extends TdFunction {
  String get tdType => 'sendChatAction';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_thread_id;
  ChatAction? action;

  SendChatAction({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_thread_id,
    this.action,
  });

  SendChatAction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    action = TdApiMap.fromMap(map['action']) as ChatAction;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'action': action?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

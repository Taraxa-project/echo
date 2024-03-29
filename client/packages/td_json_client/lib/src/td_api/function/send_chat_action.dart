import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_action.dart';

/// Sends a notification about user activity in a chat
class SendChatAction extends TdFunction {
  String get tdType => 'sendChatAction';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// If not 0, a message thread identifier in which the action was performed
  int53? message_thread_id;

  /// The action description; pass null to cancel the currently active action
  ChatAction? action;

  SendChatAction({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.action,
  });

  SendChatAction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    if (map['action'] != null) {
      action = TdApiMap.fromMap(map['action']) as ChatAction;
    }
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

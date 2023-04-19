import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/draft_message.dart';

/// Changes the draft message in a chat
class SetChatDraftMessage extends TdFunction {
  String get tdType => 'setChatDraftMessage';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// If not 0, a message thread identifier in which the draft was changed
  int53? message_thread_id;

  /// New draft message; pass null to remove the draft
  DraftMessage? draft_message;

  SetChatDraftMessage({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.draft_message,
  });

  SetChatDraftMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    if (map['draft_message'] != null) {
      draft_message = TdApiMap.fromMap(map['draft_message']) as DraftMessage;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'draft_message': draft_message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

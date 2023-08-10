import 'package:td_json_client/src/td_api/td.dart';

/// Deletes existing chat folder
class DeleteChatFolder extends TdFunction {
  String get tdType => 'deleteChatFolder';
  String get tdReturnType => 'Ok';

  /// Chat folder identifier
  int32? chat_folder_id;

  /// Identifiers of the chats to leave. The chats must be pinned or always included in the folder
  vector<int53>? leave_chat_ids;

  DeleteChatFolder({
    super.extra,
    super.client_id,
    this.chat_folder_id,
    this.leave_chat_ids,
  });

  DeleteChatFolder.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_folder_id = map['chat_folder_id'];
    if (map['leave_chat_ids'] != null) {
      leave_chat_ids = [];
      for (var someValue in map['leave_chat_ids']) {
        leave_chat_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folder_id': chat_folder_id?.toMap(skipNulls: skipNulls),
      'leave_chat_ids': leave_chat_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

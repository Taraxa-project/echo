import 'package:td_json_client/src/td_api/td.dart';

/// Process new chats added to a shareable chat folder by its owner
class ProcessChatFolderNewChats extends TdFunction {
  String get tdType => 'processChatFolderNewChats';
  String get tdReturnType => 'Ok';

  /// Chat folder identifier
  int32? chat_folder_id;

  /// Identifiers of the new chats, which are added to the chat folder. The chats are automatically joined if they aren't joined yet
  vector<int53>? added_chat_ids;

  ProcessChatFolderNewChats({
    super.extra,
    super.client_id,
    this.chat_folder_id,
    this.added_chat_ids,
  });

  ProcessChatFolderNewChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_folder_id = map['chat_folder_id'];
    if (map['added_chat_ids'] != null) {
      added_chat_ids = [];
      for (var someValue in map['added_chat_ids']) {
        added_chat_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folder_id': chat_folder_id?.toMap(skipNulls: skipNulls),
      'added_chat_ids': added_chat_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

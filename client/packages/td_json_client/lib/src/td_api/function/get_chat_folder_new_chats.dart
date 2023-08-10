import 'package:td_json_client/src/td_api/td.dart';

/// Returns new chats added to a shareable chat folder by its owner. The method must be called at most once in getOption("chat_folder_new_chats_update_period") for the given chat folder
class GetChatFolderNewChats extends TdFunction {
  String get tdType => 'getChatFolderNewChats';
  String get tdReturnType => 'Chats';

  /// Chat folder identifier
  int32? chat_folder_id;

  GetChatFolderNewChats({
    super.extra,
    super.client_id,
    this.chat_folder_id,
  });

  GetChatFolderNewChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_folder_id = map['chat_folder_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folder_id': chat_folder_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

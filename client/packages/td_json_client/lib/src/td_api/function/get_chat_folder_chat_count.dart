import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_folder.dart';

/// Returns approximate number of chats in a being created chat folder. Main and archive chat lists must be fully preloaded for this function to work correctly
class GetChatFolderChatCount extends TdFunction {
  String get tdType => 'getChatFolderChatCount';
  String get tdReturnType => 'Count';

  /// The new chat folder
  ChatFolder? folder;

  GetChatFolderChatCount({
    super.extra,
    super.client_id,
    this.folder,
  });

  GetChatFolderChatCount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['folder'] != null) {
      folder = TdApiMap.fromMap(map['folder']) as ChatFolder;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'folder': folder?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

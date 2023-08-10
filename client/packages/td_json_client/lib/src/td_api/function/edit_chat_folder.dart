import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_folder.dart';

/// Edits existing chat folder. Returns information about the edited chat folder
class EditChatFolder extends TdFunction {
  String get tdType => 'editChatFolder';
  String get tdReturnType => 'ChatFolderInfo';

  /// Chat folder identifier
  int32? chat_folder_id;

  /// The edited chat folder
  ChatFolder? folder;

  EditChatFolder({
    super.extra,
    super.client_id,
    this.chat_folder_id,
    this.folder,
  });

  EditChatFolder.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_folder_id = map['chat_folder_id'];
    if (map['folder'] != null) {
      folder = TdApiMap.fromMap(map['folder']) as ChatFolder;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folder_id': chat_folder_id?.toMap(skipNulls: skipNulls),
      'folder': folder?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

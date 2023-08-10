import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_folder.dart';

/// Creates new chat folder. Returns information about the created chat folder. There can be up to getOption("chat_folder_count_max") chat folders, but the limit can be increased with Telegram Premium
class CreateChatFolder extends TdFunction {
  String get tdType => 'createChatFolder';
  String get tdReturnType => 'ChatFolderInfo';

  /// The new chat folder
  ChatFolder? folder;

  CreateChatFolder({
    super.extra,
    super.client_id,
    this.folder,
  });

  CreateChatFolder.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_folder.dart';

/// Returns default icon name for a folder. Can be called synchronously
class GetChatFolderDefaultIconName extends TdFunction {
  String get tdType => 'getChatFolderDefaultIconName';
  String get tdReturnType => 'ChatFolderIcon';

  /// Chat folder
  ChatFolder? folder;

  GetChatFolderDefaultIconName({
    super.extra,
    super.client_id,
    this.folder,
  });

  GetChatFolderDefaultIconName.fromMap(Map<String, dynamic> map) {
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

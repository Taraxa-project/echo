import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_folder.dart';

/// Describes a recommended chat folder
class RecommendedChatFolder extends TdObject {
  String get tdType => 'recommendedChatFolder';

  /// The chat folder
  ChatFolder? folder;

  string? description;

  RecommendedChatFolder({
    super.extra,
    super.client_id,
    this.folder,
    this.description,
  });

  RecommendedChatFolder.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['folder'] != null) {
      folder = TdApiMap.fromMap(map['folder']) as ChatFolder;
    }
    description = map['description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'folder': folder?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

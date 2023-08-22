import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/recommended_chat_folder.dart';

/// Contains a list of recommended chat folders
class RecommendedChatFolders extends TdObject {
  String get tdType => 'recommendedChatFolders';

  /// List of recommended chat folders
  vector<RecommendedChatFolder>? chat_folders;

  RecommendedChatFolders({
    super.extra,
    super.client_id,
    this.chat_folders,
  });

  RecommendedChatFolders.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['chat_folders'] != null) {
      chat_folders = [];
      for (var someValue in map['chat_folders']) {
        if (someValue != null) {
          chat_folders?.add(TdApiMap.fromMap(someValue) as RecommendedChatFolder);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folders': chat_folders?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

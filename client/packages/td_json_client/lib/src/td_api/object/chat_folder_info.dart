import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_folder_icon.dart';

/// Contains basic information about a chat folder
class ChatFolderInfo extends TdObject {
  String get tdType => 'chatFolderInfo';

  /// Unique chat folder identifier
  int32? id;

  /// The title of the folder; 1-12 characters without line feeds
  string? title;

  /// The chosen or default icon for the chat folder
  ChatFolderIcon? icon;

  /// True, if at least one link has been created for the folder
  Bool? is_shareable;

  /// True, if the chat folder has invite links created by the current user
  Bool? has_my_invite_links;

  ChatFolderInfo({
    super.extra,
    super.client_id,
    this.id,
    this.title,
    this.icon,
    this.is_shareable,
    this.has_my_invite_links,
  });

  ChatFolderInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    if (map['icon'] != null) {
      icon = TdApiMap.fromMap(map['icon']) as ChatFolderIcon;
    }
    is_shareable = map['is_shareable'];
    has_my_invite_links = map['has_my_invite_links'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'icon': icon?.toMap(skipNulls: skipNulls),
      'is_shareable': is_shareable?.toMap(skipNulls: skipNulls),
      'has_my_invite_links': has_my_invite_links?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

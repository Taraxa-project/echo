import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_folder_invite_link.dart';

/// Represents a list of chat folder invite links
class ChatFolderInviteLinks extends TdObject {
  String get tdType => 'chatFolderInviteLinks';

  /// List of the invite links
  vector<ChatFolderInviteLink>? invite_links;

  ChatFolderInviteLinks({
    super.extra,
    super.client_id,
    this.invite_links,
  });

  ChatFolderInviteLinks.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['invite_links'] != null) {
      invite_links = [];
      for (var someValue in map['invite_links']) {
        if (someValue != null) {
          invite_links?.add(TdApiMap.fromMap(someValue) as ChatFolderInviteLink);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invite_links': invite_links?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

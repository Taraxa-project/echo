import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_invite_link.dart';

/// Contains a list of chat invite links
class ChatInviteLinks extends TdObject {
  String get tdType => 'chatInviteLinks';

  /// Approximate total number of chat invite links found
  int32? total_count;

  /// List of invite links
  vector<ChatInviteLink>? invite_links;

  ChatInviteLinks({
    super.extra,
    super.client_id,
    this.total_count,
    this.invite_links,
  });

  ChatInviteLinks.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['invite_links'] != null) {
      invite_links = [];
      for (var someValue in map['invite_links']) {
        if (someValue != null) {
          invite_links?.add(TdApiMap.fromMap(someValue) as ChatInviteLink);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'invite_links': invite_links?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

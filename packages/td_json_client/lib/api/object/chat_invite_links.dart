import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_invite_link.dart';

class ChatInviteLinks extends TdObject {
  String get tdType => 'chatInviteLinks';

  string? extra;
  int? client_id;
  int32? total_count;
  vector<ChatInviteLink>? invite_links;

  ChatInviteLinks({
    this.extra,
    this.client_id,
    this.total_count,
    this.invite_links,
  });

  ChatInviteLinks.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['invite_links']) {
      invite_links = [];
      for (var someValue in map['invite_links']) {
        invite_links?.add(TdApiMap.fromMap(someValue) as ChatInviteLink);
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

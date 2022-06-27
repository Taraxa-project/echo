import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_invite_link_member.dart';

class ChatInviteLinkMembers extends TdObject {
  String get tdType => 'chatInviteLinkMembers';

  String? extra;
  int? client_id;
  int32? total_count;
  vector<ChatInviteLinkMember>? members;

  ChatInviteLinkMembers({
    this.extra,
    this.client_id,
    this.total_count,
    this.members,
  });

  ChatInviteLinkMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['members']) {
      members = [];
      for (var someValue in map['members']) {
        members?.add(TdApiMap.fromMap(someValue) as ChatInviteLinkMember);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'members': members?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

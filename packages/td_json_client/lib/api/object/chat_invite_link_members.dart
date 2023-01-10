import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_invite_link_member.dart';


/// Contains a list of chat members joined a chat via an invite link 
class ChatInviteLinkMembers extends TdObject {
  String get tdType => 'chatInviteLinkMembers';


  /// Approximate total number of chat members found 
  int32? total_count;

  /// List of chat members, joined a chat via an invite link
  vector<ChatInviteLinkMember>? members;

  ChatInviteLinkMembers({
    super.extra,
    super.client_id,
    this.total_count,
    this.members,
  });

  ChatInviteLinkMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['members'] != null) {
      members = [];
      for (var someValue in map['members']) {
        if (someValue != null) {
          members?.add(TdApiMap.fromMap(someValue) as ChatInviteLinkMember);
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
      'members': members?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

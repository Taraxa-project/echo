import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_invite_link_member.dart';

/// Returns chat members joined a chat via an invite link. Requires administrator privileges and can_invite_users right in the chat for own links and owner privileges for other links
class GetChatInviteLinkMembers extends TdFunction {
  String get tdType => 'getChatInviteLinkMembers';
  String get tdReturnType => 'ChatInviteLinkMembers';

  /// Chat identifier
  int53? chat_id;

  /// Invite link for which to return chat members
  string? invite_link;

  /// A chat member from which to return next chat members; pass null to get results from the beginning
  ChatInviteLinkMember? offset_member;

  /// The maximum number of chat members to return; up to 100
  int32? limit;

  GetChatInviteLinkMembers({
    super.extra,
    super.client_id,
    this.chat_id,
    this.invite_link,
    this.offset_member,
    this.limit,
  });

  GetChatInviteLinkMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    invite_link = map['invite_link'];
    if (map['offset_member'] != null) {
      offset_member =
          TdApiMap.fromMap(map['offset_member']) as ChatInviteLinkMember;
    }
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'offset_member': offset_member?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';


/// Returns information about an invite link. Requires administrator privileges and can_invite_users right in the chat to get own links and owner privileges to get other links
class GetChatInviteLink extends TdFunction {
  String get tdType => 'getChatInviteLink';
  String get tdReturnType => 'ChatInviteLink';


  /// Chat identifier
  int53? chat_id;

  /// Invite link to get
  string? invite_link;

  GetChatInviteLink({
    super.extra,
    super.client_id,
    this.chat_id,
    this.invite_link,
  });

  GetChatInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    invite_link = map['invite_link'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

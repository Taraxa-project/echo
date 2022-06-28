import 'package:td_json_client/api/base.dart';


/// Deletes revoked chat invite links. Requires administrator privileges and can_invite_users right in the chat for own links and owner privileges for other links 
class DeleteRevokedChatInviteLink extends TdFunction {
  String get tdType => 'deleteRevokedChatInviteLink';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier 
  int53? chat_id;

  /// Invite link to revoke
  string? invite_link;

  DeleteRevokedChatInviteLink({
    this.extra,
    this.client_id,
    this.chat_id,
    this.invite_link,
  });

  DeleteRevokedChatInviteLink.fromMap(Map<String, dynamic> map) {
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

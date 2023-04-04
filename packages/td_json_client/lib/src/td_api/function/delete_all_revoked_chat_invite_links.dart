import 'package:td_json_client/src/td_api/td.dart';

/// Deletes all revoked chat invite links created by a given chat administrator. Requires administrator privileges and can_invite_users right in the chat for own links and owner privileges for other links
class DeleteAllRevokedChatInviteLinks extends TdFunction {
  String get tdType => 'deleteAllRevokedChatInviteLinks';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// User identifier of a chat administrator, which links will be deleted. Must be an identifier of the current user for non-owner
  int53? creator_user_id;

  DeleteAllRevokedChatInviteLinks({
    super.extra,
    super.client_id,
    this.chat_id,
    this.creator_user_id,
  });

  DeleteAllRevokedChatInviteLinks.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    creator_user_id = map['creator_user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'creator_user_id': creator_user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

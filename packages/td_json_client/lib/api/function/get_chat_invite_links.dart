import 'package:td_json_client/api/base.dart';


/// Returns invite links for a chat created by specified administrator. Requires administrator privileges and can_invite_users right in the chat to get own links and owner privileges to get other links
class GetChatInviteLinks extends TdFunction {
  String get tdType => 'getChatInviteLinks';
  String get tdReturnType => 'ChatInviteLinks';


  /// Chat identifier
  int53? chat_id;

  /// User identifier of a chat administrator. Must be an identifier of the current user for non-owner
  int53? creator_user_id;

  /// Pass true if revoked links needs to be returned instead of active or expired
  Bool? is_revoked;

  /// Creation date of an invite link starting after which to return invite links; use 0 to get results from the beginning
  int32? offset_date;

  /// Invite link starting after which to return invite links; use empty string to get results from the beginning
  string? offset_invite_link;

  /// The maximum number of invite links to return; up to 100
  int32? limit;

  GetChatInviteLinks({
    super.extra,
    super.client_id,
    this.chat_id,
    this.creator_user_id,
    this.is_revoked,
    this.offset_date,
    this.offset_invite_link,
    this.limit,
  });

  GetChatInviteLinks.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    creator_user_id = map['creator_user_id'];
    is_revoked = map['is_revoked'];
    offset_date = map['offset_date'];
    offset_invite_link = map['offset_invite_link'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'creator_user_id': creator_user_id?.toMap(skipNulls: skipNulls),
      'is_revoked': is_revoked?.toMap(skipNulls: skipNulls),
      'offset_date': offset_date?.toMap(skipNulls: skipNulls),
      'offset_invite_link': offset_invite_link?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

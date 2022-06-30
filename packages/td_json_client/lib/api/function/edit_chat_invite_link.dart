import 'package:td_json_client/api/base.dart';


/// Edits a non-primary invite link for a chat. Available for basic groups, supergroups, and channels. Requires administrator privileges and can_invite_users right in the chat for own links and owner privileges for other links
class EditChatInviteLink extends TdFunction {
  String get tdType => 'editChatInviteLink';
  String get tdReturnType => 'ChatInviteLink';


  /// Chat identifier
  int53? chat_id;

  /// Invite link to be edited
  string? invite_link;

  /// Invite link name; 0-32 characters
  string? name;

  /// Point in time (Unix timestamp) when the link will expire; pass 0 if never
  int32? expiration_date;

  /// The maximum number of chat members that can join the chat via the link simultaneously; 0-99999; pass 0 if not limited
  int32? member_limit;

  /// True, if the link only creates join request. If true, member_limit must not be specified
  Bool? creates_join_request;

  EditChatInviteLink({
    super.extra,
    super.client_id,
    this.chat_id,
    this.invite_link,
    this.name,
    this.expiration_date,
    this.member_limit,
    this.creates_join_request,
  });

  EditChatInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    invite_link = map['invite_link'];
    name = map['name'];
    expiration_date = map['expiration_date'];
    member_limit = map['member_limit'];
    creates_join_request = map['creates_join_request'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'expiration_date': expiration_date?.toMap(skipNulls: skipNulls),
      'member_limit': member_limit?.toMap(skipNulls: skipNulls),
      'creates_join_request': creates_join_request?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

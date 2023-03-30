import 'package:td_json_client/src/td_api/td.dart';

/// Contains a chat invite link
class ChatInviteLink extends TdObject {
  String get tdType => 'chatInviteLink';

  /// Chat invite link
  string? invite_link;

  /// Name of the link
  string? name;

  /// User identifier of an administrator created the link
  int53? creator_user_id;

  /// Point in time (Unix timestamp) when the link was created
  int32? date;

  /// Point in time (Unix timestamp) when the link was last edited; 0 if never or unknown
  int32? edit_date;

  /// Point in time (Unix timestamp) when the link will expire; 0 if never
  int32? expiration_date;

  /// The maximum number of members, which can join the chat using the link simultaneously; 0 if not limited. Always 0 if the link requires approval
  int32? member_limit;

  /// Number of chat members, which joined the chat using the link
  int32? member_count;

  /// Number of pending join requests created using this link
  int32? pending_join_request_count;

  /// True, if the link only creates join request. If true, total number of joining members will be unlimited
  Bool? creates_join_request;

  /// True, if the link is primary. Primary invite link can't have name, expiration date, or usage limit. There is exactly one primary invite link for each administrator with can_invite_users right at a given time
  Bool? is_primary;

  /// True, if the link was revoked
  Bool? is_revoked;

  ChatInviteLink({
    super.extra,
    super.client_id,
    this.invite_link,
    this.name,
    this.creator_user_id,
    this.date,
    this.edit_date,
    this.expiration_date,
    this.member_limit,
    this.member_count,
    this.pending_join_request_count,
    this.creates_join_request,
    this.is_primary,
    this.is_revoked,
  });

  ChatInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    invite_link = map['invite_link'];
    name = map['name'];
    creator_user_id = map['creator_user_id'];
    date = map['date'];
    edit_date = map['edit_date'];
    expiration_date = map['expiration_date'];
    member_limit = map['member_limit'];
    member_count = map['member_count'];
    pending_join_request_count = map['pending_join_request_count'];
    creates_join_request = map['creates_join_request'];
    is_primary = map['is_primary'];
    is_revoked = map['is_revoked'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'creator_user_id': creator_user_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'edit_date': edit_date?.toMap(skipNulls: skipNulls),
      'expiration_date': expiration_date?.toMap(skipNulls: skipNulls),
      'member_limit': member_limit?.toMap(skipNulls: skipNulls),
      'member_count': member_count?.toMap(skipNulls: skipNulls),
      'pending_join_request_count':
          pending_join_request_count?.toMap(skipNulls: skipNulls),
      'creates_join_request': creates_join_request?.toMap(skipNulls: skipNulls),
      'is_primary': is_primary?.toMap(skipNulls: skipNulls),
      'is_revoked': is_revoked?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

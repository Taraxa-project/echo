import 'package:td_json_client/api/base.dart';

class ChatInviteLink extends TdObject {
  String get tdType => 'chatInviteLink';

  string? extra;
  int? client_id;
  string? invite_link;
  string? name;
  int53? creator_user_id;
  int32? date;
  int32? edit_date;
  int32? expiration_date;
  int32? member_limit;
  int32? member_count;
  int32? pending_join_request_count;
  Bool? creates_join_request;
  Bool? is_primary;
  Bool? is_revoked;

  ChatInviteLink({
    this.extra,
    this.client_id,
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
      'pending_join_request_count': pending_join_request_count?.toMap(skipNulls: skipNulls),
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

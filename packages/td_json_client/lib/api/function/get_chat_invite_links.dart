import 'package:td_json_client/api/base.dart';

class GetChatInviteLinks extends TdFunction {
  String get tdType => 'getChatInviteLinks';
  String get tdReturnType => 'ChatInviteLinks';

  String? extra;
  int? client_id;
  int53? chat_id;
  int53? creator_user_id;
  Bool? is_revoked;
  int32? offset_date;
  string? offset_invite_link;
  int32? limit;

  GetChatInviteLinks({
    this.extra,
    this.client_id,
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

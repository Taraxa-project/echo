import 'package:td_json_client/api/base.dart';

class EditChatInviteLink extends TdFunction {
  String get tdType => 'editChatInviteLink';
  String get tdReturnType => 'ChatInviteLink';

  String? extra;
  int? client_id;
  int53? chat_id;
  string? invite_link;
  string? name;
  int32? expiration_date;
  int32? member_limit;
  Bool? creates_join_request;

  EditChatInviteLink({
    this.extra,
    this.client_id,
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

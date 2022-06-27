import 'package:td_json_client/api/base.dart';

class CheckChatInviteLink extends TdFunction {
  String get tdType => 'checkChatInviteLink';
  String get tdReturnType => 'ChatInviteLinkInfo';

  string? extra;
  int? client_id;
  string? invite_link;

  CheckChatInviteLink({
    this.extra,
    this.client_id,
    this.invite_link,
  });

  CheckChatInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    invite_link = map['invite_link'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

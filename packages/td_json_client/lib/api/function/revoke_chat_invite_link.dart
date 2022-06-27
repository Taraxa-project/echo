import 'package:td_json_client/api/base.dart';

class RevokeChatInviteLink extends TdFunction {
  String get tdType => 'revokeChatInviteLink';
  String get tdReturnType => 'ChatInviteLinks';

  String? extra;
  int? client_id;
  int53? chat_id;
  string? invite_link;

  RevokeChatInviteLink({
    this.extra,
    this.client_id,
    this.chat_id,
    this.invite_link,
  });

  RevokeChatInviteLink.fromMap(Map<String, dynamic> map) {
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

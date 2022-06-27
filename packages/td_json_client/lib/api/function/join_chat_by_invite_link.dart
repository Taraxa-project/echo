import 'package:td_json_client/api/base.dart';


/// Uses an invite link to add the current user to the chat if possible 
class JoinChatByInviteLink extends TdFunction {
  String get tdType => 'joinChatByInviteLink';
  String get tdReturnType => 'Chat';

  String? extra;
  int? client_id;

  /// Invite link to use
  string? invite_link;

  JoinChatByInviteLink({
    this.extra,
    this.client_id,
    this.invite_link,
  });

  JoinChatByInviteLink.fromMap(Map<String, dynamic> map) {
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

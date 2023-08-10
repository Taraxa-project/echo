import 'package:td_json_client/src/td_api/td.dart';

/// Checks the validity of an invite link for a chat folder and returns information about the corresponding chat folder
class CheckChatFolderInviteLink extends TdFunction {
  String get tdType => 'checkChatFolderInviteLink';
  String get tdReturnType => 'ChatFolderInviteLinkInfo';

  /// Invite link to be checked
  string? invite_link;

  CheckChatFolderInviteLink({
    super.extra,
    super.client_id,
    this.invite_link,
  });

  CheckChatFolderInviteLink.fromMap(Map<String, dynamic> map) {
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

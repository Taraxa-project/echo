import 'package:td_json_client/api/base.dart';


/// Describes a chat administrator with a number of active and revoked chat invite links
class ChatInviteLinkCount extends TdObject {
  String get tdType => 'chatInviteLinkCount';


  /// Administrator's user identifier
  int53? user_id;

  /// Number of active invite links
  int32? invite_link_count;

  /// Number of revoked invite links
  int32? revoked_invite_link_count;

  ChatInviteLinkCount({
    super.extra,
    super.client_id,
    this.user_id,
    this.invite_link_count,
    this.revoked_invite_link_count,
  });

  ChatInviteLinkCount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    invite_link_count = map['invite_link_count'];
    revoked_invite_link_count = map['revoked_invite_link_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'invite_link_count': invite_link_count?.toMap(skipNulls: skipNulls),
      'revoked_invite_link_count': revoked_invite_link_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

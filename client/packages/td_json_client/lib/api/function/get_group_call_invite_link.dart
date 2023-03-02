import 'package:td_json_client/api/base.dart';


/// Returns invite link to a video chat in a public chat
class GetGroupCallInviteLink extends TdFunction {
  String get tdType => 'getGroupCallInviteLink';
  String get tdReturnType => 'HttpUrl';


  /// Group call identifier
  int32? group_call_id;

  /// Pass true if the invite link needs to contain an invite hash, passing which to joinGroupCall would allow the invited user to unmute themselves. Requires groupCall.can_be_managed group call flag
  Bool? can_self_unmute;

  GetGroupCallInviteLink({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.can_self_unmute,
  });

  GetGroupCallInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    can_self_unmute = map['can_self_unmute'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'can_self_unmute': can_self_unmute?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

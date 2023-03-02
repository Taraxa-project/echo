import 'package:td_json_client/api/base.dart';


/// Handles all pending join requests for a given link in a chat
class ProcessChatJoinRequests extends TdFunction {
  String get tdType => 'processChatJoinRequests';
  String get tdReturnType => 'Ok';


  /// Chat identifier
  int53? chat_id;

  /// Invite link for which to process join requests. If empty, all join requests will be processed. Requires administrator privileges and can_invite_users right in the chat for own links and owner privileges for other links
  string? invite_link;

  /// Pass true to approve all requests; pass false to decline them
  Bool? approve;

  ProcessChatJoinRequests({
    super.extra,
    super.client_id,
    this.chat_id,
    this.invite_link,
    this.approve,
  });

  ProcessChatJoinRequests.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    invite_link = map['invite_link'];
    approve = map['approve'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'approve': approve?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

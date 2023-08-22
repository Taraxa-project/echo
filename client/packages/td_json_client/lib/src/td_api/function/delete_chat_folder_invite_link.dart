import 'package:td_json_client/src/td_api/td.dart';

/// Deletes an invite link for a chat folder
class DeleteChatFolderInviteLink extends TdFunction {
  String get tdType => 'deleteChatFolderInviteLink';
  String get tdReturnType => 'Ok';

  /// Chat folder identifier
  int32? chat_folder_id;

  /// Invite link to be deleted
  string? invite_link;

  DeleteChatFolderInviteLink({
    super.extra,
    super.client_id,
    this.chat_folder_id,
    this.invite_link,
  });

  DeleteChatFolderInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_folder_id = map['chat_folder_id'];
    invite_link = map['invite_link'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folder_id': chat_folder_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

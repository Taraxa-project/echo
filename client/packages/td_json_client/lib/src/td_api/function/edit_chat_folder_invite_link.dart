import 'package:td_json_client/src/td_api/td.dart';

/// Edits an invite link for a chat folder
class EditChatFolderInviteLink extends TdFunction {
  String get tdType => 'editChatFolderInviteLink';
  String get tdReturnType => 'ChatFolderInviteLink';

  /// Chat folder identifier
  int32? chat_folder_id;

  /// Invite link to be edited
  string? invite_link;

  /// New name of the link; 0-32 characters
  string? name;

  /// New identifiers of chats to be accessible by the invite link. Use getChatsForChatFolderInviteLink to get suitable chats. Basic groups will be automatically converted to supergroups before link editing
  vector<int53>? chat_ids;

  EditChatFolderInviteLink({
    super.extra,
    super.client_id,
    this.chat_folder_id,
    this.invite_link,
    this.name,
    this.chat_ids,
  });

  EditChatFolderInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_folder_id = map['chat_folder_id'];
    invite_link = map['invite_link'];
    name = map['name'];
    if (map['chat_ids'] != null) {
      chat_ids = [];
      for (var someValue in map['chat_ids']) {
        chat_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_folder_id': chat_folder_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'chat_ids': chat_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Creates a new invite link for a chat folder. A link can be created for a chat folder if it has only pinned and included chats
class CreateChatFolderInviteLink extends TdFunction {
  String get tdType => 'createChatFolderInviteLink';
  String get tdReturnType => 'ChatFolderInviteLink';

  /// Chat folder identifier
  int32? chat_folder_id;

  /// Name of the link; 0-32 characters
  string? name;

  /// Identifiers of chats to be accessible by the invite link. Use getChatsForChatFolderInviteLink to get suitable chats. Basic groups will be automatically converted to supergroups before link creation
  vector<int53>? chat_ids;

  CreateChatFolderInviteLink({
    super.extra,
    super.client_id,
    this.chat_folder_id,
    this.name,
    this.chat_ids,
  });

  CreateChatFolderInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_folder_id = map['chat_folder_id'];
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
      'name': name?.toMap(skipNulls: skipNulls),
      'chat_ids': chat_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

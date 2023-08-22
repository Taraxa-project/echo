import 'package:td_json_client/src/td_api/td.dart';

/// Adds a chat folder by an invite link
class AddChatFolderByInviteLink extends TdFunction {
  String get tdType => 'addChatFolderByInviteLink';
  String get tdReturnType => 'Ok';

  /// Invite link for the chat folder
  string? invite_link;

  /// Identifiers of the chats added to the chat folder. The chats are automatically joined if they aren't joined yet
  vector<int53>? chat_ids;

  AddChatFolderByInviteLink({
    super.extra,
    super.client_id,
    this.invite_link,
    this.chat_ids,
  });

  AddChatFolderByInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    invite_link = map['invite_link'];
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
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
      'chat_ids': chat_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

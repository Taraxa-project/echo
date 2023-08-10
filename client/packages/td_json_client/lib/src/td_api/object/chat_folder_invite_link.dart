import 'package:td_json_client/src/td_api/td.dart';

/// Contains a chat folder invite link
class ChatFolderInviteLink extends TdObject {
  String get tdType => 'chatFolderInviteLink';

  /// The chat folder invite link
  string? invite_link;

  /// Name of the link
  string? name;

  /// Identifiers of chats, included in the link
  vector<int53>? chat_ids;

  ChatFolderInviteLink({
    super.extra,
    super.client_id,
    this.invite_link,
    this.name,
    this.chat_ids,
  });

  ChatFolderInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
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

import 'package:td_json_client/api/base.dart';

/// Searches a public chat by its username. Currently, only private chats, supergroups and channels can be public. Returns the chat if found; otherwise an error is returned
class SearchPublicChat extends TdFunction {
  String get tdType => 'searchPublicChat';
  String get tdReturnType => 'Chat';

  /// Username to be resolved
  string? username;

  SearchPublicChat({
    super.extra,
    super.client_id,
    this.username,
  });

  SearchPublicChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    username = map['username'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

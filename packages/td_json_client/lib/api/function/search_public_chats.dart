import 'package:td_json_client/api/base.dart';

/// Searches public chats by looking for specified query in their username and title. Currently, only private chats, supergroups and channels can be public. Returns a meaningful number of results.
/// Excludes private chats with contacts and chats from the chat list from the results
class SearchPublicChats extends TdFunction {
  String get tdType => 'searchPublicChats';
  String get tdReturnType => 'Chats';

  /// Query to search for
  string? query;

  SearchPublicChats({
    super.extra,
    super.client_id,
    this.query,
  });

  SearchPublicChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

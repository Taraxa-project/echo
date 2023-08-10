import 'package:td_json_client/src/td_api/td.dart';

/// Searches for the specified query in the title and username of up to 50 recently found chats; this is an offline request
class SearchRecentlyFoundChats extends TdFunction {
  String get tdType => 'searchRecentlyFoundChats';
  String get tdReturnType => 'Chats';

  /// Query to search for
  string? query;

  /// The maximum number of chats to be returned
  int32? limit;

  SearchRecentlyFoundChats({
    super.extra,
    super.client_id,
    this.query,
    this.limit,
  });

  SearchRecentlyFoundChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

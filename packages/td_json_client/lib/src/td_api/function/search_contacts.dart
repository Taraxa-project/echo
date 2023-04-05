import 'package:td_json_client/src/td_api/td.dart';

/// Searches for the specified query in the first names, last names and usernames of the known user contacts
class SearchContacts extends TdFunction {
  String get tdType => 'searchContacts';
  String get tdReturnType => 'Users';

  /// Query to search for; may be empty to return all contacts
  string? query;

  /// The maximum number of users to be returned
  int32? limit;

  SearchContacts({
    super.extra,
    super.client_id,
    this.query,
    this.limit,
  });

  SearchContacts.fromMap(Map<String, dynamic> map) {
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

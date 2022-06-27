import 'package:td_json_client/api/base.dart';


/// Searches for the specified query in the title and username of already known chats, this is an offline request. Returns chats in the order seen in the main chat list 
class SearchChats extends TdFunction {
  String get tdType => 'searchChats';
  String get tdReturnType => 'Chats';

  String? extra;
  int? client_id;

  /// Query to search for. If the query is empty, returns up to 50 recently found chats 
  string? query;

  /// The maximum number of chats to be returned
  int32? limit;

  SearchChats({
    this.extra,
    this.client_id,
    this.query,
    this.limit,
  });

  SearchChats.fromMap(Map<String, dynamic> map) {
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

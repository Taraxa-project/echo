import 'package:td_json_client/api/base.dart';


/// Searches for outgoing messages with content of the type messageDocument in all chats except secret chats. Returns the results in reverse chronological order
class SearchOutgoingDocumentMessages extends TdFunction {
  String get tdType => 'searchOutgoingDocumentMessages';
  String get tdReturnType => 'FoundMessages';

  String? extra;
  int? client_id;

  /// Query to search for in document file name and message caption
  string? query;

  /// The maximum number of messages to be returned; up to 100
  int32? limit;

  SearchOutgoingDocumentMessages({
    this.extra,
    this.client_id,
    this.query,
    this.limit,
  });

  SearchOutgoingDocumentMessages.fromMap(Map<String, dynamic> map) {
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

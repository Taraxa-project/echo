import 'package:td_json_client/api/base.dart';

class SearchOutgoingDocumentMessages extends TdFunction {
  String get tdType => 'searchOutgoingDocumentMessages';
  String get tdReturnType => 'FoundMessages';

  string? extra;
  int? client_id;
  string? query;
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

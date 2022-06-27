import 'package:td_json_client/api/base.dart';

class SearchFileDownloads extends TdFunction {
  String get tdType => 'searchFileDownloads';
  String get tdReturnType => 'FoundFileDownloads';

  String? extra;
  int? client_id;
  string? query;
  Bool? only_active;
  Bool? only_completed;
  string? offset;
  int32? limit;

  SearchFileDownloads({
    this.extra,
    this.client_id,
    this.query,
    this.only_active,
    this.only_completed,
    this.offset,
    this.limit,
  });

  SearchFileDownloads.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
    only_active = map['only_active'];
    only_completed = map['only_completed'];
    offset = map['offset'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'only_active': only_active?.toMap(skipNulls: skipNulls),
      'only_completed': only_completed?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

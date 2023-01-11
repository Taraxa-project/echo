import 'package:td_json_client/api/base.dart';


/// Searches for call messages. Returns the results in reverse chronological order (i.e., in order of decreasing message_id). For optimal performance, the number of returned messages is chosen by TDLib
class SearchCallMessages extends TdFunction {
  String get tdType => 'searchCallMessages';
  String get tdReturnType => 'FoundMessages';


  /// Offset of the first entry to return as received from the previous request; use empty string to get the first chunk of results
  string? offset;

  /// The maximum number of messages to be returned; up to 100. For optimal performance, the number of returned messages is chosen by TDLib and can be smaller than the specified limit
  int32? limit;

  /// Pass true to search only for messages with missed/declined calls
  Bool? only_missed;

  SearchCallMessages({
    super.extra,
    super.client_id,
    this.offset,
    this.limit,
    this.only_missed,
  });

  SearchCallMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    offset = map['offset'];
    limit = map['limit'];
    only_missed = map['only_missed'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'only_missed': only_missed?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

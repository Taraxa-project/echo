import 'package:td_json_client/api/base.dart';


/// Searches for call messages. Returns the results in reverse chronological order (i.e., in order of decreasing message_id). For optimal performance, the number of returned messages is chosen by TDLib
class SearchCallMessages extends TdFunction {
  String get tdType => 'searchCallMessages';
  String get tdReturnType => 'Messages';


  /// Identifier of the message from which to search; use 0 to get results from the last message
  int53? from_message_id;

  /// The maximum number of messages to be returned; up to 100. For optimal performance, the number of returned messages is chosen by TDLib and can be smaller than the specified limit
  int32? limit;

  /// Pass true to search only for messages with missed/declined calls
  Bool? only_missed;

  SearchCallMessages({
    super.extra,
    super.client_id,
    this.from_message_id,
    this.limit,
    this.only_missed,
  });

  SearchCallMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    from_message_id = map['from_message_id'];
    limit = map['limit'];
    only_missed = map['only_missed'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'from_message_id': from_message_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'only_missed': only_missed?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';


/// Returns messages in a chat. The messages are returned in a reverse chronological order (i.e., in order of decreasing message_id).
/// For optimal performance, the number of returned messages is chosen by TDLib. This is an offline request if only_local is true
class GetChatHistory extends TdFunction {
  String get tdType => 'getChatHistory';
  String get tdReturnType => 'Messages';


  /// Chat identifier
  int53? chat_id;

  /// Identifier of the message starting from which history must be fetched; use 0 to get results from the last message
  int53? from_message_id;

  /// Specify 0 to get results from exactly the from_message_id or a negative offset up to 99 to get additionally some newer messages
  int32? offset;

  /// The maximum number of messages to be returned; must be positive and can't be greater than 100. If the offset is negative, the limit must be greater than or equal to -offset. For optimal performance, the number of returned messages is chosen by TDLib and can be smaller than the specified limit
  int32? limit;

  /// If true, returns only messages that are available locally without sending network requests
  Bool? only_local;

  GetChatHistory({
    super.extra,
    super.client_id,
    this.chat_id,
    this.from_message_id,
    this.offset,
    this.limit,
    this.only_local,
  });

  GetChatHistory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    from_message_id = map['from_message_id'];
    offset = map['offset'];
    limit = map['limit'];
    only_local = map['only_local'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'from_message_id': from_message_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
      'only_local': only_local?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

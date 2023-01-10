import 'package:td_json_client/api/base.dart';


/// Returns information about the recent locations of chat members that were sent to the chat. Returns up to 1 location message per user 
class SearchChatRecentLocationMessages extends TdFunction {
  String get tdType => 'searchChatRecentLocationMessages';
  String get tdReturnType => 'Messages';


  /// Chat identifier 
  int53? chat_id;

  /// The maximum number of messages to be returned
  int32? limit;

  SearchChatRecentLocationMessages({
    super.extra,
    super.client_id,
    this.chat_id,
    this.limit,
  });

  SearchChatRecentLocationMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

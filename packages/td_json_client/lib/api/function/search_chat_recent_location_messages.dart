import 'package:td_json_client/api/base.dart';

class SearchChatRecentLocationMessages extends TdFunction {
  String get tdType => 'searchChatRecentLocationMessages';
  String get tdReturnType => 'Messages';

  string? extra;
  int? client_id;
  int53? chat_id;
  int32? limit;

  SearchChatRecentLocationMessages({
    this.extra,
    this.client_id,
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

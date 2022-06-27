import 'package:td_json_client/api/base.dart';

class GetChatHistory extends TdFunction {
  String get tdType => 'getChatHistory';
  String get tdReturnType => 'Messages';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? from_message_id;
  int32? offset;
  int32? limit;
  Bool? only_local;

  GetChatHistory({
    this.extra,
    this.client_id,
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

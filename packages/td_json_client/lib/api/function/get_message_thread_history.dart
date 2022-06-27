import 'package:td_json_client/api/base.dart';

class GetMessageThreadHistory extends TdFunction {
  String get tdType => 'getMessageThreadHistory';
  String get tdReturnType => 'Messages';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  int53? from_message_id;
  int32? offset;
  int32? limit;

  GetMessageThreadHistory({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.from_message_id,
    this.offset,
    this.limit,
  });

  GetMessageThreadHistory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    from_message_id = map['from_message_id'];
    offset = map['offset'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'from_message_id': from_message_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';

/// Returns the last message sent in a chat no later than the specified date
class GetChatMessageByDate extends TdFunction {
  String get tdType => 'getChatMessageByDate';
  String get tdReturnType => 'Message';

  /// Chat identifier
  int53? chat_id;

  /// Point in time (Unix timestamp) relative to which to search for messages
  int32? date;

  GetChatMessageByDate({
    super.extra,
    super.client_id,
    this.chat_id,
    this.date,
  });

  GetChatMessageByDate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    date = map['date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

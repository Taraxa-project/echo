import 'package:td_json_client/src/td_api/td.dart';

/// Deletes all messages between the specified dates in a chat. Supported only for private chats and basic groups. Messages sent in the last 30 seconds will not be deleted
class DeleteChatMessagesByDate extends TdFunction {
  String get tdType => 'deleteChatMessagesByDate';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// The minimum date of the messages to delete
  int32? min_date;

  /// The maximum date of the messages to delete
  int32? max_date;

  /// Pass true to delete chat messages for all users; private chats only
  Bool? revoke;

  DeleteChatMessagesByDate({
    super.extra,
    super.client_id,
    this.chat_id,
    this.min_date,
    this.max_date,
    this.revoke,
  });

  DeleteChatMessagesByDate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    min_date = map['min_date'];
    max_date = map['max_date'];
    revoke = map['revoke'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'min_date': min_date?.toMap(skipNulls: skipNulls),
      'max_date': max_date?.toMap(skipNulls: skipNulls),
      'revoke': revoke?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

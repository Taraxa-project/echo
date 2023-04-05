import 'package:td_json_client/src/td_api/td.dart';

/// Deletes messages
class DeleteMessages extends TdFunction {
  String get tdType => 'deleteMessages';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// Identifiers of the messages to be deleted
  vector<int53>? message_ids;

  /// Pass true to delete messages for all chat members. Always true for supergroups, channels and secret chats
  Bool? revoke;

  DeleteMessages({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_ids,
    this.revoke,
  });

  DeleteMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_ids'] != null) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
    revoke = map['revoke'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
      'revoke': revoke?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

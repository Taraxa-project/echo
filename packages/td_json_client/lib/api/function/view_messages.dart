import 'package:td_json_client/api/base.dart';


/// Informs TDLib that messages are being viewed by the user. Sponsored messages must be marked as viewed only when the entire text of the message is shown on the screen (excluding the button). Many useful activities depend on whether the messages are currently being viewed or not (e.g., marking messages as read, incrementing a view counter, updating a view counter, removing deleted messages in supergroups and channels)
class ViewMessages extends TdFunction {
  String get tdType => 'viewMessages';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  /// If not 0, a message thread identifier in which the messages are being viewed
  int53? message_thread_id;

  /// The identifiers of the messages being viewed
  vector<int53>? message_ids;

  /// Pass true to mark as read the specified messages even the chat is closed
  Bool? force_read;

  ViewMessages({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_thread_id,
    this.message_ids,
    this.force_read,
  });

  ViewMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    if (map['message_ids']) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
    force_read = map['force_read'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
      'force_read': force_read?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

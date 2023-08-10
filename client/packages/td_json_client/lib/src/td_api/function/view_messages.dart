import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_source.dart';

/// Informs TDLib that messages are being viewed by the user. Sponsored messages must be marked as viewed only when the entire text of the message is shown on the screen (excluding the button).
/// Many useful activities depend on whether the messages are currently being viewed or not (e.g., marking messages as read, incrementing a view counter, updating a view counter, removing deleted messages in supergroups and channels)
class ViewMessages extends TdFunction {
  String get tdType => 'viewMessages';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// The identifiers of the messages being viewed
  vector<int53>? message_ids;

  /// Source of the message view; pass null to guess the source based on chat open state
  MessageSource? source;

  /// Pass true to mark as read the specified messages even the chat is closed
  Bool? force_read;

  ViewMessages({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_ids,
    this.source,
    this.force_read,
  });

  ViewMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_ids'] != null) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
    if (map['source'] != null) {
      source = TdApiMap.fromMap(map['source']) as MessageSource;
    }
    force_read = map['force_read'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
      'source': source?.toMap(skipNulls: skipNulls),
      'force_read': force_read?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_reply_info.dart';
import 'package:td_json_client/api/object/message.dart';
import 'package:td_json_client/api/object/draft_message.dart';

/// Contains information about a message thread
class MessageThreadInfo extends TdObject {
  String get tdType => 'messageThreadInfo';

  /// Identifier of the chat to which the message thread belongs
  int53? chat_id;

  /// Message thread identifier, unique within the chat
  int53? message_thread_id;

  /// Information about the message thread; may be null for forum topic threads
  MessageReplyInfo? reply_info;

  /// Approximate number of unread messages in the message thread
  int32? unread_message_count;

  /// The messages from which the thread starts. The messages are returned in a reverse chronological order (i.e., in order of decreasing message_id)
  vector<Message>? messages;

  /// A draft of a message in the message thread; may be null
  DraftMessage? draft_message;

  MessageThreadInfo({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_thread_id,
    this.reply_info,
    this.unread_message_count,
    this.messages,
    this.draft_message,
  });

  MessageThreadInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_thread_id = map['message_thread_id'];
    if (map['reply_info'] != null) {
      reply_info = TdApiMap.fromMap(map['reply_info']) as MessageReplyInfo;
    }
    unread_message_count = map['unread_message_count'];
    if (map['messages'] != null) {
      messages = [];
      for (var someValue in map['messages']) {
        if (someValue != null) {
          messages?.add(TdApiMap.fromMap(someValue) as Message);
        }
      }
    }
    if (map['draft_message'] != null) {
      draft_message = TdApiMap.fromMap(map['draft_message']) as DraftMessage;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
      'reply_info': reply_info?.toMap(skipNulls: skipNulls),
      'unread_message_count': unread_message_count?.toMap(skipNulls: skipNulls),
      'messages': messages?.toMap(skipNulls: skipNulls),
      'draft_message': draft_message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

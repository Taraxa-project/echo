import 'package:td_json_client/api/base.dart';


/// Blocks an original sender of a message in the Replies chat
class BlockMessageSenderFromReplies extends TdFunction {
  String get tdType => 'blockMessageSenderFromReplies';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// The identifier of an incoming message in the Replies chat
  int53? message_id;

  /// Pass true to delete the message
  Bool? delete_message;

  /// Pass true to delete all messages from the same sender
  Bool? delete_all_messages;

  /// Pass true to report the sender to the Telegram moderators
  Bool? report_spam;

  BlockMessageSenderFromReplies({
    this.extra,
    this.client_id,
    this.message_id,
    this.delete_message,
    this.delete_all_messages,
    this.report_spam,
  });

  BlockMessageSenderFromReplies.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_id = map['message_id'];
    delete_message = map['delete_message'];
    delete_all_messages = map['delete_all_messages'];
    report_spam = map['report_spam'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'delete_message': delete_message?.toMap(skipNulls: skipNulls),
      'delete_all_messages': delete_all_messages?.toMap(skipNulls: skipNulls),
      'report_spam': report_spam?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

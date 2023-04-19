import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Reports reactions set on a message to the Telegram moderators. Reactions on a message can be reported only if message.can_report_reactions
class ReportMessageReactions extends TdFunction {
  String get tdType => 'reportMessageReactions';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// Message identifier
  int53? message_id;

  /// Identifier of the sender, which added the reaction
  MessageSender? sender_id;

  ReportMessageReactions({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.sender_id,
  });

  ReportMessageReactions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['sender_id'] != null) {
      sender_id = TdApiMap.fromMap(map['sender_id']) as MessageSender;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'sender_id': sender_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_report_reason.dart';

/// Reports a chat to the Telegram moderators. A chat can be reported only from the chat action bar, or if chat.can_be_reported
class ReportChat extends TdFunction {
  String get tdType => 'reportChat';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// Identifiers of reported messages; may be empty to report the whole chat
  vector<int53>? message_ids;

  /// The reason for reporting the chat
  ChatReportReason? reason;

  /// Additional report details; 0-1024 characters
  string? text;

  ReportChat({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_ids,
    this.reason,
    this.text,
  });

  ReportChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_ids'] != null) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
    if (map['reason'] != null) {
      reason = TdApiMap.fromMap(map['reason']) as ChatReportReason;
    }
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_ids': message_ids?.toMap(skipNulls: skipNulls),
      'reason': reason?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_report_reason.dart';

class ReportChat extends TdFunction {
  String get tdType => 'reportChat';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  vector<int53>? message_ids;
  ChatReportReason? reason;
  string? text;

  ReportChat({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_ids,
    this.reason,
    this.text,
  });

  ReportChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['message_ids']) {
      message_ids = [];
      for (var someValue in map['message_ids']) {
        message_ids?.add(someValue);
      }
    }
    reason = TdApiMap.fromMap(map['reason']) as ChatReportReason;
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

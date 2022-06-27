import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_report_reason.dart';

class ReportChatPhoto extends TdFunction {
  String get tdType => 'reportChatPhoto';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  int32? file_id;
  ChatReportReason? reason;
  string? text;

  ReportChatPhoto({
    this.extra,
    this.client_id,
    this.chat_id,
    this.file_id,
    this.reason,
    this.text,
  });

  ReportChatPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    file_id = map['file_id'];
    reason = TdApiMap.fromMap(map['reason']) as ChatReportReason;
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'reason': reason?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

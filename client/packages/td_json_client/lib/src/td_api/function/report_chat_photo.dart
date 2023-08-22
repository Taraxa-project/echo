import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/report_reason.dart';

/// Reports a chat photo to the Telegram moderators. A chat photo can be reported only if chat.can_be_reported
class ReportChatPhoto extends TdFunction {
  String get tdType => 'reportChatPhoto';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// Identifier of the photo to report. Only full photos from chatPhoto can be reported
  int32? file_id;

  /// The reason for reporting the chat photo
  ReportReason? reason;

  /// Additional report details; 0-1024 characters
  string? text;

  ReportChatPhoto({
    super.extra,
    super.client_id,
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
    if (map['reason'] != null) {
      reason = TdApiMap.fromMap(map['reason']) as ReportReason;
    }
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

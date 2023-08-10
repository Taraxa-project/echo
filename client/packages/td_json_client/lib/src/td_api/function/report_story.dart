import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/report_reason.dart';

/// Reports a story to the Telegram moderators
class ReportStory extends TdFunction {
  String get tdType => 'reportStory';
  String get tdReturnType => 'Ok';

  /// The identifier of the sender of the story to report
  int53? story_sender_chat_id;

  /// The identifier of the story to report
  int32? story_id;

  /// The reason for reporting the story
  ReportReason? reason;

  /// Additional report details; 0-1024 characters
  string? text;

  ReportStory({
    super.extra,
    super.client_id,
    this.story_sender_chat_id,
    this.story_id,
    this.reason,
    this.text,
  });

  ReportStory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_sender_chat_id = map['story_sender_chat_id'];
    story_id = map['story_id'];
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
      'story_sender_chat_id': story_sender_chat_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
      'reason': reason?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

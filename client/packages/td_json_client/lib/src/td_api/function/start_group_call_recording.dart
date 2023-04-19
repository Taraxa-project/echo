import 'package:td_json_client/src/td_api/td.dart';

/// Starts recording of an active group call. Requires groupCall.can_be_managed group call flag
class StartGroupCallRecording extends TdFunction {
  String get tdType => 'startGroupCallRecording';
  String get tdReturnType => 'Ok';

  /// Group call identifier
  int32? group_call_id;

  /// Group call recording title; 0-64 characters
  string? title;

  /// Pass true to record a video file instead of an audio file
  Bool? record_video;

  /// Pass true to use portrait orientation for video instead of landscape one
  Bool? use_portrait_orientation;

  StartGroupCallRecording({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.title,
    this.record_video,
    this.use_portrait_orientation,
  });

  StartGroupCallRecording.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    title = map['title'];
    record_video = map['record_video'];
    use_portrait_orientation = map['use_portrait_orientation'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'record_video': record_video?.toMap(skipNulls: skipNulls),
      'use_portrait_orientation': use_portrait_orientation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

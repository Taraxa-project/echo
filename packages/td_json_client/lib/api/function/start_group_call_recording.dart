import 'package:td_json_client/api/base.dart';

class StartGroupCallRecording extends TdFunction {
  String get tdType => 'startGroupCallRecording';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int32? group_call_id;
  string? title;
  Bool? record_video;
  Bool? use_portrait_orientation;

  StartGroupCallRecording({
    this.extra,
    this.client_id,
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

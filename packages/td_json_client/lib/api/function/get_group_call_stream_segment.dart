import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/group_call_video_quality.dart';

class GetGroupCallStreamSegment extends TdFunction {
  String get tdType => 'getGroupCallStreamSegment';
  String get tdReturnType => 'FilePart';

  string? extra;
  int? client_id;
  int32? group_call_id;
  int53? time_offset;
  int32? scale;
  int32? channel_id;
  GroupCallVideoQuality? video_quality;

  GetGroupCallStreamSegment({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.time_offset,
    this.scale,
    this.channel_id,
    this.video_quality,
  });

  GetGroupCallStreamSegment.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    time_offset = map['time_offset'];
    scale = map['scale'];
    channel_id = map['channel_id'];
    video_quality = TdApiMap.fromMap(map['video_quality']) as GroupCallVideoQuality;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'time_offset': time_offset?.toMap(skipNulls: skipNulls),
      'scale': scale?.toMap(skipNulls: skipNulls),
      'channel_id': channel_id?.toMap(skipNulls: skipNulls),
      'video_quality': video_quality?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

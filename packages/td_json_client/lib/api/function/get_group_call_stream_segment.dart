import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/group_call_video_quality.dart';


/// Returns a file with a segment of a group call stream in a modified OGG format for audio or MPEG-4 format for video
class GetGroupCallStreamSegment extends TdFunction {
  String get tdType => 'getGroupCallStreamSegment';
  String get tdReturnType => 'FilePart';


  /// Group call identifier
  int32? group_call_id;

  /// Point in time when the stream segment begins; Unix timestamp in milliseconds
  int53? time_offset;

  /// Segment duration scale; 0-1. Segment's duration is 1000/(2**scale) milliseconds
  int32? scale;

  /// Identifier of an audio/video channel to get as received from tgcalls
  int32? channel_id;

  /// Video quality as received from tgcalls; pass null to get the worst available quality
  GroupCallVideoQuality? video_quality;

  GetGroupCallStreamSegment({
    super.extra,
    super.client_id,
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
    if (map['video_quality'] != null) {
      video_quality = TdApiMap.fromMap(map['video_quality']) as GroupCallVideoQuality;
    }
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

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/group_call_video_source_group.dart';


/// Contains information about a group call participant's video channel 
class GroupCallParticipantVideoInfo extends TdObject {
  String get tdType => 'groupCallParticipantVideoInfo';

  String? extra;
  int? client_id;

  /// List of synchronization source groups of the video 
  vector<GroupCallVideoSourceGroup>? source_groups;

  /// Video channel endpoint identifier
  string? endpoint_id;

  /// True if the video is paused. This flag needs to be ignored, if new video frames are received
  Bool? is_paused;

  GroupCallParticipantVideoInfo({
    this.extra,
    this.client_id,
    this.source_groups,
    this.endpoint_id,
    this.is_paused,
  });

  GroupCallParticipantVideoInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['source_groups'] != null) {
      source_groups = [];
      for (var someValue in map['source_groups']) {
        if (someValue != null) {
          source_groups?.add(TdApiMap.fromMap(someValue) as GroupCallVideoSourceGroup);
        }
      }
    }
    endpoint_id = map['endpoint_id'];
    is_paused = map['is_paused'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'source_groups': source_groups?.toMap(skipNulls: skipNulls),
      'endpoint_id': endpoint_id?.toMap(skipNulls: skipNulls),
      'is_paused': is_paused?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/group_call_video_source_group.dart';

class GroupCallParticipantVideoInfo extends TdObject {
  String get tdType => 'groupCallParticipantVideoInfo';

  string? extra;
  int? client_id;
  vector<GroupCallVideoSourceGroup>? source_groups;
  string? endpoint_id;
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
    if (map['source_groups']) {
      source_groups = [];
      for (var someValue in map['source_groups']) {
        source_groups?.add(TdApiMap.fromMap(someValue) as GroupCallVideoSourceGroup);
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

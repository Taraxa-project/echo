import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/group_call_recent_speaker.dart';

class GroupCall extends TdObject {
  String get tdType => 'groupCall';

  string? extra;
  int? client_id;
  int32? id;
  string? title;
  int32? scheduled_start_date;
  Bool? enabled_start_notification;
  Bool? is_active;
  Bool? is_joined;
  Bool? need_rejoin;
  Bool? can_be_managed;
  int32? participant_count;
  Bool? loaded_all_participants;
  vector<GroupCallRecentSpeaker>? recent_speakers;
  Bool? is_my_video_enabled;
  Bool? is_my_video_paused;
  Bool? can_enable_video;
  Bool? mute_new_participants;
  Bool? can_toggle_mute_new_participants;
  int32? record_duration;
  Bool? is_video_recorded;
  int32? duration;

  GroupCall({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.scheduled_start_date,
    this.enabled_start_notification,
    this.is_active,
    this.is_joined,
    this.need_rejoin,
    this.can_be_managed,
    this.participant_count,
    this.loaded_all_participants,
    this.recent_speakers,
    this.is_my_video_enabled,
    this.is_my_video_paused,
    this.can_enable_video,
    this.mute_new_participants,
    this.can_toggle_mute_new_participants,
    this.record_duration,
    this.is_video_recorded,
    this.duration,
  });

  GroupCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    scheduled_start_date = map['scheduled_start_date'];
    enabled_start_notification = map['enabled_start_notification'];
    is_active = map['is_active'];
    is_joined = map['is_joined'];
    need_rejoin = map['need_rejoin'];
    can_be_managed = map['can_be_managed'];
    participant_count = map['participant_count'];
    loaded_all_participants = map['loaded_all_participants'];
    if (map['recent_speakers']) {
      recent_speakers = [];
      for (var someValue in map['recent_speakers']) {
        recent_speakers?.add(TdApiMap.fromMap(someValue) as GroupCallRecentSpeaker);
      }
    }
    is_my_video_enabled = map['is_my_video_enabled'];
    is_my_video_paused = map['is_my_video_paused'];
    can_enable_video = map['can_enable_video'];
    mute_new_participants = map['mute_new_participants'];
    can_toggle_mute_new_participants = map['can_toggle_mute_new_participants'];
    record_duration = map['record_duration'];
    is_video_recorded = map['is_video_recorded'];
    duration = map['duration'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'scheduled_start_date': scheduled_start_date?.toMap(skipNulls: skipNulls),
      'enabled_start_notification': enabled_start_notification?.toMap(skipNulls: skipNulls),
      'is_active': is_active?.toMap(skipNulls: skipNulls),
      'is_joined': is_joined?.toMap(skipNulls: skipNulls),
      'need_rejoin': need_rejoin?.toMap(skipNulls: skipNulls),
      'can_be_managed': can_be_managed?.toMap(skipNulls: skipNulls),
      'participant_count': participant_count?.toMap(skipNulls: skipNulls),
      'loaded_all_participants': loaded_all_participants?.toMap(skipNulls: skipNulls),
      'recent_speakers': recent_speakers?.toMap(skipNulls: skipNulls),
      'is_my_video_enabled': is_my_video_enabled?.toMap(skipNulls: skipNulls),
      'is_my_video_paused': is_my_video_paused?.toMap(skipNulls: skipNulls),
      'can_enable_video': can_enable_video?.toMap(skipNulls: skipNulls),
      'mute_new_participants': mute_new_participants?.toMap(skipNulls: skipNulls),
      'can_toggle_mute_new_participants': can_toggle_mute_new_participants?.toMap(skipNulls: skipNulls),
      'record_duration': record_duration?.toMap(skipNulls: skipNulls),
      'is_video_recorded': is_video_recorded?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

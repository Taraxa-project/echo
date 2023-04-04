import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/group_call_recent_speaker.dart';

/// Describes a group call
class GroupCall extends TdObject {
  String get tdType => 'groupCall';

  /// Group call identifier
  int32? id;

  /// Group call title
  string? title;

  /// Point in time (Unix timestamp) when the group call is supposed to be started by an administrator; 0 if it is already active or was ended
  int32? scheduled_start_date;

  /// True, if the group call is scheduled and the current user will receive a notification when the group call will start
  Bool? enabled_start_notification;

  /// True, if the call is active
  Bool? is_active;

  /// True, if the chat is an RTMP stream instead of an ordinary video chat
  Bool? is_rtmp_stream;

  /// True, if the call is joined
  Bool? is_joined;

  /// True, if user was kicked from the call because of network loss and the call needs to be rejoined
  Bool? need_rejoin;

  /// True, if the current user can manage the group call
  Bool? can_be_managed;

  /// Number of participants in the group call
  int32? participant_count;

  /// True, if group call participants, which are muted, aren't returned in participant list
  Bool? has_hidden_listeners;

  /// True, if all group call participants are loaded
  Bool? loaded_all_participants;

  /// At most 3 recently speaking users in the group call
  vector<GroupCallRecentSpeaker>? recent_speakers;

  /// True, if the current user's video is enabled
  Bool? is_my_video_enabled;

  /// True, if the current user's video is paused
  Bool? is_my_video_paused;

  /// True, if the current user can broadcast video or share screen
  Bool? can_enable_video;

  /// True, if only group call administrators can unmute new participants
  Bool? mute_new_participants;

  /// True, if the current user can enable or disable mute_new_participants setting
  Bool? can_toggle_mute_new_participants;

  /// Duration of the ongoing group call recording, in seconds; 0 if none. An updateGroupCall update is not triggered when value of this field changes, but the same recording goes on
  int32? record_duration;

  /// True, if a video file is being recorded for the call
  Bool? is_video_recorded;

  /// Call duration, in seconds; for ended calls only
  int32? duration;

  GroupCall({
    super.extra,
    super.client_id,
    this.id,
    this.title,
    this.scheduled_start_date,
    this.enabled_start_notification,
    this.is_active,
    this.is_rtmp_stream,
    this.is_joined,
    this.need_rejoin,
    this.can_be_managed,
    this.participant_count,
    this.has_hidden_listeners,
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
    is_rtmp_stream = map['is_rtmp_stream'];
    is_joined = map['is_joined'];
    need_rejoin = map['need_rejoin'];
    can_be_managed = map['can_be_managed'];
    participant_count = map['participant_count'];
    has_hidden_listeners = map['has_hidden_listeners'];
    loaded_all_participants = map['loaded_all_participants'];
    if (map['recent_speakers'] != null) {
      recent_speakers = [];
      for (var someValue in map['recent_speakers']) {
        if (someValue != null) {
          recent_speakers?.add(TdApiMap.fromMap(someValue) as GroupCallRecentSpeaker);
        }
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
      'is_rtmp_stream': is_rtmp_stream?.toMap(skipNulls: skipNulls),
      'is_joined': is_joined?.toMap(skipNulls: skipNulls),
      'need_rejoin': need_rejoin?.toMap(skipNulls: skipNulls),
      'can_be_managed': can_be_managed?.toMap(skipNulls: skipNulls),
      'participant_count': participant_count?.toMap(skipNulls: skipNulls),
      'has_hidden_listeners': has_hidden_listeners?.toMap(skipNulls: skipNulls),
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

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/group_call_participant_video_info.dart';

class GroupCallParticipant extends TdObject {
  String get tdType => 'groupCallParticipant';

  String? extra;
  int? client_id;
  MessageSender? participant_id;
  int32? audio_source_id;
  int32? screen_sharing_audio_source_id;
  GroupCallParticipantVideoInfo? video_info;
  GroupCallParticipantVideoInfo? screen_sharing_video_info;
  string? bio;
  Bool? is_current_user;
  Bool? is_speaking;
  Bool? is_hand_raised;
  Bool? can_be_muted_for_all_users;
  Bool? can_be_unmuted_for_all_users;
  Bool? can_be_muted_for_current_user;
  Bool? can_be_unmuted_for_current_user;
  Bool? is_muted_for_all_users;
  Bool? is_muted_for_current_user;
  Bool? can_unmute_self;
  int32? volume_level;
  string? order;

  GroupCallParticipant({
    this.extra,
    this.client_id,
    this.participant_id,
    this.audio_source_id,
    this.screen_sharing_audio_source_id,
    this.video_info,
    this.screen_sharing_video_info,
    this.bio,
    this.is_current_user,
    this.is_speaking,
    this.is_hand_raised,
    this.can_be_muted_for_all_users,
    this.can_be_unmuted_for_all_users,
    this.can_be_muted_for_current_user,
    this.can_be_unmuted_for_current_user,
    this.is_muted_for_all_users,
    this.is_muted_for_current_user,
    this.can_unmute_self,
    this.volume_level,
    this.order,
  });

  GroupCallParticipant.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
    audio_source_id = map['audio_source_id'];
    screen_sharing_audio_source_id = map['screen_sharing_audio_source_id'];
    video_info = TdApiMap.fromMap(map['video_info']) as GroupCallParticipantVideoInfo;
    screen_sharing_video_info = TdApiMap.fromMap(map['screen_sharing_video_info']) as GroupCallParticipantVideoInfo;
    bio = map['bio'];
    is_current_user = map['is_current_user'];
    is_speaking = map['is_speaking'];
    is_hand_raised = map['is_hand_raised'];
    can_be_muted_for_all_users = map['can_be_muted_for_all_users'];
    can_be_unmuted_for_all_users = map['can_be_unmuted_for_all_users'];
    can_be_muted_for_current_user = map['can_be_muted_for_current_user'];
    can_be_unmuted_for_current_user = map['can_be_unmuted_for_current_user'];
    is_muted_for_all_users = map['is_muted_for_all_users'];
    is_muted_for_current_user = map['is_muted_for_current_user'];
    can_unmute_self = map['can_unmute_self'];
    volume_level = map['volume_level'];
    order = map['order'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'participant_id': participant_id?.toMap(skipNulls: skipNulls),
      'audio_source_id': audio_source_id?.toMap(skipNulls: skipNulls),
      'screen_sharing_audio_source_id': screen_sharing_audio_source_id?.toMap(skipNulls: skipNulls),
      'video_info': video_info?.toMap(skipNulls: skipNulls),
      'screen_sharing_video_info': screen_sharing_video_info?.toMap(skipNulls: skipNulls),
      'bio': bio?.toMap(skipNulls: skipNulls),
      'is_current_user': is_current_user?.toMap(skipNulls: skipNulls),
      'is_speaking': is_speaking?.toMap(skipNulls: skipNulls),
      'is_hand_raised': is_hand_raised?.toMap(skipNulls: skipNulls),
      'can_be_muted_for_all_users': can_be_muted_for_all_users?.toMap(skipNulls: skipNulls),
      'can_be_unmuted_for_all_users': can_be_unmuted_for_all_users?.toMap(skipNulls: skipNulls),
      'can_be_muted_for_current_user': can_be_muted_for_current_user?.toMap(skipNulls: skipNulls),
      'can_be_unmuted_for_current_user': can_be_unmuted_for_current_user?.toMap(skipNulls: skipNulls),
      'is_muted_for_all_users': is_muted_for_all_users?.toMap(skipNulls: skipNulls),
      'is_muted_for_current_user': is_muted_for_current_user?.toMap(skipNulls: skipNulls),
      'can_unmute_self': can_unmute_self?.toMap(skipNulls: skipNulls),
      'volume_level': volume_level?.toMap(skipNulls: skipNulls),
      'order': order?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

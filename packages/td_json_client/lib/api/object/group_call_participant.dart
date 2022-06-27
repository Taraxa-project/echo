import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';
import 'package:td_json_client/api/object/group_call_participant_video_info.dart';


/// Represents a group call participant
class GroupCallParticipant extends TdObject {
  String get tdType => 'groupCallParticipant';

  String? extra;
  int? client_id;

  /// Identifier of the group call participant
  MessageSender? participant_id;

  /// User's audio channel synchronization source identifier
  int32? audio_source_id;

  /// User's screen sharing audio channel synchronization source identifier
  int32? screen_sharing_audio_source_id;

  /// Information about user's video channel; may be null if there is no active video
  GroupCallParticipantVideoInfo? video_info;

  /// Information about user's screen sharing video channel; may be null if there is no active screen sharing video
  GroupCallParticipantVideoInfo? screen_sharing_video_info;

  /// The participant user's bio or the participant chat's description
  string? bio;

  /// True, if the participant is the current user
  Bool? is_current_user;

  /// True, if the participant is speaking as set by setGroupCallParticipantIsSpeaking
  Bool? is_speaking;

  /// True, if the participant hand is raised
  Bool? is_hand_raised;

  /// True, if the current user can mute the participant for all other group call participants
  Bool? can_be_muted_for_all_users;

  /// True, if the current user can allow the participant to unmute themselves or unmute the participant (if the participant is the current user)
  Bool? can_be_unmuted_for_all_users;

  /// True, if the current user can mute the participant only for self
  Bool? can_be_muted_for_current_user;

  /// True, if the current user can unmute the participant for self
  Bool? can_be_unmuted_for_current_user;

  /// True, if the participant is muted for all users
  Bool? is_muted_for_all_users;

  /// True, if the participant is muted for the current user
  Bool? is_muted_for_current_user;

  /// True, if the participant is muted for all users, but can unmute themselves
  Bool? can_unmute_self;

  /// Participant's volume level; 1-20000 in hundreds of percents
  int32? volume_level;

  /// User's order in the group call participant list. Orders must be compared lexicographically. The bigger is order, the higher is user in the list. If order is empty, the user must be removed from the participant list
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

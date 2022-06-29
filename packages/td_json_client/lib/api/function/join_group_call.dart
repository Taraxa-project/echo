import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';


/// Joins an active group call. Returns join response payload for tgcalls
class JoinGroupCall extends TdFunction {
  String get tdType => 'joinGroupCall';
  String get tdReturnType => 'Text';

  String? extra;
  int? client_id;

  /// Group call identifier
  int32? group_call_id;

  /// Identifier of a group call participant, which will be used to join the call; pass null to join as self; video chats only
  MessageSender? participant_id;

  /// Caller audio channel synchronization source identifier; received from tgcalls
  int32? audio_source_id;

  /// Group call join payload; received from tgcalls
  string? payload;

  /// True, if the user's microphone is muted
  Bool? is_muted;

  /// True, if the user's video is enabled
  Bool? is_my_video_enabled;

  /// If non-empty, invite hash to be used to join the group call without being muted by administrators
  string? invite_hash;

  JoinGroupCall({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.participant_id,
    this.audio_source_id,
    this.payload,
    this.is_muted,
    this.is_my_video_enabled,
    this.invite_hash,
  });

  JoinGroupCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    if (map['participant_id'] != null) {
      participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
    }
    audio_source_id = map['audio_source_id'];
    payload = map['payload'];
    is_muted = map['is_muted'];
    is_my_video_enabled = map['is_my_video_enabled'];
    invite_hash = map['invite_hash'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'participant_id': participant_id?.toMap(skipNulls: skipNulls),
      'audio_source_id': audio_source_id?.toMap(skipNulls: skipNulls),
      'payload': payload?.toMap(skipNulls: skipNulls),
      'is_muted': is_muted?.toMap(skipNulls: skipNulls),
      'is_my_video_enabled': is_my_video_enabled?.toMap(skipNulls: skipNulls),
      'invite_hash': invite_hash?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

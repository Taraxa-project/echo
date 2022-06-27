import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class JoinGroupCall extends TdFunction {
  String get tdType => 'joinGroupCall';
  String get tdReturnType => 'Text';

  string? extra;
  int? client_id;
  int32? group_call_id;
  MessageSender? participant_id;
  int32? audio_source_id;
  string? payload;
  Bool? is_muted;
  Bool? is_my_video_enabled;
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
    participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
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

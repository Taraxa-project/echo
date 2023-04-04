import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_sender.dart';

/// Changes volume level of a participant of an active group call. If the current user can manage the group call, then the participant's volume level will be changed for all users with the default volume level
class SetGroupCallParticipantVolumeLevel extends TdFunction {
  String get tdType => 'setGroupCallParticipantVolumeLevel';
  String get tdReturnType => 'Ok';

  /// Group call identifier
  int32? group_call_id;

  /// Participant identifier
  MessageSender? participant_id;

  /// New participant's volume level; 1-20000 in hundreds of percents
  int32? volume_level;

  SetGroupCallParticipantVolumeLevel({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.participant_id,
    this.volume_level,
  });

  SetGroupCallParticipantVolumeLevel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    if (map['participant_id'] != null) {
      participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
    }
    volume_level = map['volume_level'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'participant_id': participant_id?.toMap(skipNulls: skipNulls),
      'volume_level': volume_level?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';


/// Toggles whether a participant of an active group call is muted, unmuted, or allowed to unmute themselves
class ToggleGroupCallParticipantIsMuted extends TdFunction {
  String get tdType => 'toggleGroupCallParticipantIsMuted';
  String get tdReturnType => 'Ok';


  /// Group call identifier 
  int32? group_call_id;

  /// Participant identifier 
  MessageSender? participant_id;

  /// Pass true if the user must be muted and false otherwise
  Bool? is_muted;

  ToggleGroupCallParticipantIsMuted({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.participant_id,
    this.is_muted,
  });

  ToggleGroupCallParticipantIsMuted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    if (map['participant_id'] != null) {
      participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
    }
    is_muted = map['is_muted'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'participant_id': participant_id?.toMap(skipNulls: skipNulls),
      'is_muted': is_muted?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

/// Toggles whether a group call participant hand is rased
class ToggleGroupCallParticipantIsHandRaised extends TdFunction {
  String get tdType => 'toggleGroupCallParticipantIsHandRaised';
  String get tdReturnType => 'Ok';

  /// Group call identifier
  int32? group_call_id;

  /// Participant identifier
  MessageSender? participant_id;

  /// Pass true if the user's hand needs to be raised. Only self hand can be raised. Requires groupCall.can_be_managed group call flag to lower other's hand
  Bool? is_hand_raised;

  ToggleGroupCallParticipantIsHandRaised({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.participant_id,
    this.is_hand_raised,
  });

  ToggleGroupCallParticipantIsHandRaised.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    if (map['participant_id'] != null) {
      participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
    }
    is_hand_raised = map['is_hand_raised'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'participant_id': participant_id?.toMap(skipNulls: skipNulls),
      'is_hand_raised': is_hand_raised?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

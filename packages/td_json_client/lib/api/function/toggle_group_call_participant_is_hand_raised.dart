import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class ToggleGroupCallParticipantIsHandRaised extends TdFunction {
  String get tdType => 'toggleGroupCallParticipantIsHandRaised';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int32? group_call_id;
  MessageSender? participant_id;
  Bool? is_hand_raised;

  ToggleGroupCallParticipantIsHandRaised({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.participant_id,
    this.is_hand_raised,
  });

  ToggleGroupCallParticipantIsHandRaised.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
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

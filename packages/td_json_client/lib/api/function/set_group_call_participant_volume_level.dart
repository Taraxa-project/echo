import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message_sender.dart';

class SetGroupCallParticipantVolumeLevel extends TdFunction {
  String get tdType => 'setGroupCallParticipantVolumeLevel';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? group_call_id;
  MessageSender? participant_id;
  int32? volume_level;

  SetGroupCallParticipantVolumeLevel({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.participant_id,
    this.volume_level,
  });

  SetGroupCallParticipantVolumeLevel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    participant_id = TdApiMap.fromMap(map['participant_id']) as MessageSender;
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

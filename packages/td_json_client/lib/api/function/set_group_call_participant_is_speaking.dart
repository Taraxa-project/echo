import 'package:td_json_client/api/base.dart';

class SetGroupCallParticipantIsSpeaking extends TdFunction {
  String get tdType => 'setGroupCallParticipantIsSpeaking';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int32? group_call_id;
  int32? audio_source;
  Bool? is_speaking;

  SetGroupCallParticipantIsSpeaking({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.audio_source,
    this.is_speaking,
  });

  SetGroupCallParticipantIsSpeaking.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    audio_source = map['audio_source'];
    is_speaking = map['is_speaking'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'audio_source': audio_source?.toMap(skipNulls: skipNulls),
      'is_speaking': is_speaking?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';

class ToggleGroupCallMuteNewParticipants extends TdFunction {
  String get tdType => 'toggleGroupCallMuteNewParticipants';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int32? group_call_id;
  Bool? mute_new_participants;

  ToggleGroupCallMuteNewParticipants({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.mute_new_participants,
  });

  ToggleGroupCallMuteNewParticipants.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    mute_new_participants = map['mute_new_participants'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'mute_new_participants': mute_new_participants?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

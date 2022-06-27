import 'package:td_json_client/api/base.dart';


/// Toggles whether new participants of a group call can be unmuted only by administrators of the group call. Requires groupCall.can_toggle_mute_new_participants group call flag
class ToggleGroupCallMuteNewParticipants extends TdFunction {
  String get tdType => 'toggleGroupCallMuteNewParticipants';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Group call identifier 
  int32? group_call_id;

  /// New value of the mute_new_participants setting
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

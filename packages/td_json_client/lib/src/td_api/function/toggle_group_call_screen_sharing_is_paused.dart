import 'package:td_json_client/src/td_api/td.dart';

/// Pauses or unpauses screen sharing in a joined group call
class ToggleGroupCallScreenSharingIsPaused extends TdFunction {
  String get tdType => 'toggleGroupCallScreenSharingIsPaused';
  String get tdReturnType => 'Ok';

  /// Group call identifier
  int32? group_call_id;

  /// Pass true to pause screen sharing; pass false to unpause it
  Bool? is_paused;

  ToggleGroupCallScreenSharingIsPaused({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.is_paused,
  });

  ToggleGroupCallScreenSharingIsPaused.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    is_paused = map['is_paused'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'is_paused': is_paused?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

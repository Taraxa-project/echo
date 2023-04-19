import 'package:td_json_client/src/td_api/td.dart';

/// Toggles whether current user's video is enabled
class ToggleGroupCallIsMyVideoEnabled extends TdFunction {
  String get tdType => 'toggleGroupCallIsMyVideoEnabled';
  String get tdReturnType => 'Ok';

  /// Group call identifier
  int32? group_call_id;

  /// Pass true if the current user's video is enabled
  Bool? is_my_video_enabled;

  ToggleGroupCallIsMyVideoEnabled({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.is_my_video_enabled,
  });

  ToggleGroupCallIsMyVideoEnabled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    is_my_video_enabled = map['is_my_video_enabled'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'is_my_video_enabled': is_my_video_enabled?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

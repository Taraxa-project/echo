import 'package:td_json_client/src/td_api/td.dart';

/// Changes active state for a username of the current user. The editable username can't be disabled. May return an error with a message "USERNAMES_ACTIVE_TOO_MUCH" if the maximum number of active usernames has been reached
class ToggleUsernameIsActive extends TdFunction {
  String get tdType => 'toggleUsernameIsActive';
  String get tdReturnType => 'Ok';

  /// The username to change
  string? username;

  /// Pass true to activate the username; pass false to disable it
  Bool? is_active;

  ToggleUsernameIsActive({
    super.extra,
    super.client_id,
    this.username,
    this.is_active,
  });

  ToggleUsernameIsActive.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    username = map['username'];
    is_active = map['is_active'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
      'is_active': is_active?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

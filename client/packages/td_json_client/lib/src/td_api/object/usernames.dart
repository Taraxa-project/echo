import 'package:td_json_client/src/td_api/td.dart';

/// Describes usernames assigned to a user, a supergroup, or a channel
class Usernames extends TdObject {
  String get tdType => 'usernames';

  /// List of active usernames; the first one must be shown as the primary username. The order of active usernames can be changed with reorderActiveUsernames, reorderBotActiveUsernames or reorderSupergroupActiveUsernames
  vector<string>? active_usernames;

  /// List of currently disabled usernames; the username can be activated with toggleUsernameIsActive, toggleBotUsernameIsActive, or toggleSupergroupUsernameIsActive
  vector<string>? disabled_usernames;

  /// The active username, which can be changed with setUsername or setSupergroupUsername
  string? editable_username;

  Usernames({
    super.extra,
    super.client_id,
    this.active_usernames,
    this.disabled_usernames,
    this.editable_username,
  });

  Usernames.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['active_usernames'] != null) {
      active_usernames = [];
      for (var someValue in map['active_usernames']) {
        active_usernames?.add(someValue);
      }
    }
    if (map['disabled_usernames'] != null) {
      disabled_usernames = [];
      for (var someValue in map['disabled_usernames']) {
        disabled_usernames?.add(someValue);
      }
    }
    editable_username = map['editable_username'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'active_usernames': active_usernames?.toMap(skipNulls: skipNulls),
      'disabled_usernames': disabled_usernames?.toMap(skipNulls: skipNulls),
      'editable_username': editable_username?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

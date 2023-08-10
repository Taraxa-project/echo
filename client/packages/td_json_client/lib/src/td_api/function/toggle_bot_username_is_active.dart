import 'package:td_json_client/src/td_api/td.dart';

/// Changes active state for a username of a bot. The editable username can't be disabled. May return an error with a message "USERNAMES_ACTIVE_TOO_MUCH" if the maximum number of active usernames has been reached. Can be called only if userTypeBot.can_be_edited == true
class ToggleBotUsernameIsActive extends TdFunction {
  String get tdType => 'toggleBotUsernameIsActive';
  String get tdReturnType => 'Ok';

  /// Identifier of the target bot
  int53? bot_user_id;

  /// The username to change
  string? username;

  /// Pass true to activate the username; pass false to disable it
  Bool? is_active;

  ToggleBotUsernameIsActive({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.username,
    this.is_active,
  });

  ToggleBotUsernameIsActive.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    username = map['username'];
    is_active = map['is_active'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
      'is_active': is_active?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

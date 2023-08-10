import 'package:td_json_client/src/td_api/td.dart';

/// Changes order of active usernames of a bot. Can be called only if userTypeBot.can_be_edited == true
class ReorderBotActiveUsernames extends TdFunction {
  String get tdType => 'reorderBotActiveUsernames';
  String get tdReturnType => 'Ok';

  /// Identifier of the target bot
  int53? bot_user_id;

  /// The new order of active usernames. All currently active usernames must be specified
  vector<string>? usernames;

  ReorderBotActiveUsernames({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.usernames,
  });

  ReorderBotActiveUsernames.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    if (map['usernames'] != null) {
      usernames = [];
      for (var someValue in map['usernames']) {
        usernames?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'usernames': usernames?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

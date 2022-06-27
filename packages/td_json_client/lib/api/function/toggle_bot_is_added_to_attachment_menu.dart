import 'package:td_json_client/api/base.dart';

class ToggleBotIsAddedToAttachmentMenu extends TdFunction {
  String get tdType => 'toggleBotIsAddedToAttachmentMenu';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? bot_user_id;
  Bool? is_added;

  ToggleBotIsAddedToAttachmentMenu({
    this.extra,
    this.client_id,
    this.bot_user_id,
    this.is_added,
  });

  ToggleBotIsAddedToAttachmentMenu.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    is_added = map['is_added'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'is_added': is_added?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

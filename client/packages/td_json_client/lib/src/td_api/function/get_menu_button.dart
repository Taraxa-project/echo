import 'package:td_json_client/src/td_api/td.dart';

/// Returns menu button set by the bot for the given user; for bots only
class GetMenuButton extends TdFunction {
  String get tdType => 'getMenuButton';
  String get tdReturnType => 'BotMenuButton';

  /// Identifier of the user or 0 to get the default menu button
  int53? user_id;

  GetMenuButton({
    super.extra,
    super.client_id,
    this.user_id,
  });

  GetMenuButton.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

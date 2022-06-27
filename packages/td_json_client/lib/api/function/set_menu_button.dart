import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/bot_menu_button.dart';

class SetMenuButton extends TdFunction {
  String get tdType => 'setMenuButton';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int53? user_id;
  BotMenuButton? menu_button;

  SetMenuButton({
    this.extra,
    this.client_id,
    this.user_id,
    this.menu_button,
  });

  SetMenuButton.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    menu_button = TdApiMap.fromMap(map['menu_button']) as BotMenuButton;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'menu_button': menu_button?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

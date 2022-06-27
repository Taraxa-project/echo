import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/inline_keyboard_button_type.dart';

class InlineKeyboardButton extends TdObject {
  String get tdType => 'inlineKeyboardButton';

  String? extra;
  int? client_id;
  string? text;
  InlineKeyboardButtonType? type;

  InlineKeyboardButton({
    this.extra,
    this.client_id,
    this.text,
    this.type,
  });

  InlineKeyboardButton.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    type = TdApiMap.fromMap(map['type']) as InlineKeyboardButtonType;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

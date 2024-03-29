import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/inline_keyboard_button_type.dart';

/// Represents a single button in an inline keyboard
class InlineKeyboardButton extends TdObject {
  String get tdType => 'inlineKeyboardButton';

  /// Text of the button
  string? text;

  /// Type of the button
  InlineKeyboardButtonType? type;

  InlineKeyboardButton({
    super.extra,
    super.client_id,
    this.text,
    this.type,
  });

  InlineKeyboardButton.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as InlineKeyboardButtonType;
    }
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

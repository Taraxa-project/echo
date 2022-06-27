import 'package:td_json_client/api/base.dart';


/// Contains parameters of the app theme 
class ThemeParameters extends TdObject {
  String get tdType => 'themeParameters';

  String? extra;
  int? client_id;

  /// A color of the background in the RGB24 format 
  int32? background_color;

  /// A color of text in the RGB24 format
  int32? text_color;

  /// A color of hints in the RGB24 format 
  int32? hint_color;

  /// A color of links in the RGB24 format 
  int32? link_color;

  /// A color of the buttons in the RGB24 format
  int32? button_color;

  /// A color of text on the buttons in the RGB24 format
  int32? button_text_color;

  ThemeParameters({
    this.extra,
    this.client_id,
    this.background_color,
    this.text_color,
    this.hint_color,
    this.link_color,
    this.button_color,
    this.button_text_color,
  });

  ThemeParameters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    background_color = map['background_color'];
    text_color = map['text_color'];
    hint_color = map['hint_color'];
    link_color = map['link_color'];
    button_color = map['button_color'];
    button_text_color = map['button_text_color'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'background_color': background_color?.toMap(skipNulls: skipNulls),
      'text_color': text_color?.toMap(skipNulls: skipNulls),
      'hint_color': hint_color?.toMap(skipNulls: skipNulls),
      'link_color': link_color?.toMap(skipNulls: skipNulls),
      'button_color': button_color?.toMap(skipNulls: skipNulls),
      'button_text_color': button_text_color?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

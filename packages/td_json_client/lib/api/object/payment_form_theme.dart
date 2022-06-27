import 'package:td_json_client/api/base.dart';

class PaymentFormTheme extends TdObject {
  String get tdType => 'paymentFormTheme';

  string? extra;
  int? client_id;
  int32? background_color;
  int32? text_color;
  int32? hint_color;
  int32? link_color;
  int32? button_color;
  int32? button_text_color;

  PaymentFormTheme({
    this.extra,
    this.client_id,
    this.background_color,
    this.text_color,
    this.hint_color,
    this.link_color,
    this.button_color,
    this.button_text_color,
  });

  PaymentFormTheme.fromMap(Map<String, dynamic> map) {
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

import 'package:td_json_client/api/base.dart';

class CallbackQueryAnswer extends TdObject {
  String get tdType => 'callbackQueryAnswer';

  String? extra;
  int? client_id;
  string? text;
  Bool? show_alert;
  string? url;

  CallbackQueryAnswer({
    this.extra,
    this.client_id,
    this.text,
    this.show_alert,
    this.url,
  });

  CallbackQueryAnswer.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    show_alert = map['show_alert'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'show_alert': show_alert?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

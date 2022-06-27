import 'package:td_json_client/api/base.dart';


/// Contains a bot's answer to a callback query 
class CallbackQueryAnswer extends TdObject {
  String get tdType => 'callbackQueryAnswer';

  String? extra;
  int? client_id;

  /// Text of the answer 
  string? text;

  /// True, if an alert must be shown to the user instead of a toast notification 
  Bool? show_alert;

  /// URL to be opened
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

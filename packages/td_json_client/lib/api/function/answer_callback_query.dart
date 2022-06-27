import 'package:td_json_client/api/base.dart';

class AnswerCallbackQuery extends TdFunction {
  String get tdType => 'answerCallbackQuery';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int64? callback_query_id;
  string? text;
  Bool? show_alert;
  string? url;
  int32? cache_time;

  AnswerCallbackQuery({
    this.extra,
    this.client_id,
    this.callback_query_id,
    this.text,
    this.show_alert,
    this.url,
    this.cache_time,
  });

  AnswerCallbackQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    callback_query_id = map['callback_query_id'];
    text = map['text'];
    show_alert = map['show_alert'];
    url = map['url'];
    cache_time = map['cache_time'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'callback_query_id': callback_query_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'show_alert': show_alert?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'cache_time': cache_time?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

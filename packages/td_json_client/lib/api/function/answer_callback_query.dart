import 'package:td_json_client/api/base.dart';


/// Sets the result of a callback query; for bots only
class AnswerCallbackQuery extends TdFunction {
  String get tdType => 'answerCallbackQuery';
  String get tdReturnType => 'Ok';


  /// Identifier of the callback query
  int64? callback_query_id;

  /// Text of the answer
  string? text;

  /// Pass true to show an alert to the user instead of a toast notification
  Bool? show_alert;

  /// URL to be opened
  string? url;

  /// Time during which the result of the query can be cached, in seconds
  int32? cache_time;

  AnswerCallbackQuery({
    super.extra,
    super.client_id,
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

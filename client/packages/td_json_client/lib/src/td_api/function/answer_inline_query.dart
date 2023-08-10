import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/inline_query_results_button.dart';
import 'package:td_json_client/src/td_api/object/input_inline_query_result.dart';

/// Sets the result of an inline query; for bots only
class AnswerInlineQuery extends TdFunction {
  String get tdType => 'answerInlineQuery';
  String get tdReturnType => 'Ok';

  /// Identifier of the inline query
  int64? inline_query_id;

  /// Pass true if results may be cached and returned only for the user that sent the query. By default, results may be returned to any user who sends the same query
  Bool? is_personal;

  /// Button to be shown above inline query results; pass null if none
  InlineQueryResultsButton? button;

  /// The results of the query
  vector<InputInlineQueryResult>? results;

  /// Allowed time to cache the results of the query, in seconds
  int32? cache_time;

  /// Offset for the next inline query; pass an empty string if there are no more results
  string? next_offset;

  AnswerInlineQuery({
    super.extra,
    super.client_id,
    this.inline_query_id,
    this.is_personal,
    this.button,
    this.results,
    this.cache_time,
    this.next_offset,
  });

  AnswerInlineQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_query_id = map['inline_query_id'];
    is_personal = map['is_personal'];
    if (map['button'] != null) {
      button = TdApiMap.fromMap(map['button']) as InlineQueryResultsButton;
    }
    if (map['results'] != null) {
      results = [];
      for (var someValue in map['results']) {
        if (someValue != null) {
          results?.add(TdApiMap.fromMap(someValue) as InputInlineQueryResult);
        }
      }
    }
    cache_time = map['cache_time'];
    next_offset = map['next_offset'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inline_query_id': inline_query_id?.toMap(skipNulls: skipNulls),
      'is_personal': is_personal?.toMap(skipNulls: skipNulls),
      'button': button?.toMap(skipNulls: skipNulls),
      'results': results?.toMap(skipNulls: skipNulls),
      'cache_time': cache_time?.toMap(skipNulls: skipNulls),
      'next_offset': next_offset?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

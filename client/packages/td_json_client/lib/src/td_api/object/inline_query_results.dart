import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/inline_query_results_button.dart';
import 'package:td_json_client/src/td_api/object/inline_query_result.dart';

/// Represents the results of the inline query. Use sendInlineQueryResultMessage to send the result of the query
class InlineQueryResults extends TdObject {
  String get tdType => 'inlineQueryResults';

  /// Unique identifier of the inline query
  int64? inline_query_id;

  /// Button to be shown above inline query results; may be null
  InlineQueryResultsButton? button;

  /// Results of the query
  vector<InlineQueryResult>? results;

  /// The offset for the next request. If empty, there are no more results
  string? next_offset;

  InlineQueryResults({
    super.extra,
    super.client_id,
    this.inline_query_id,
    this.button,
    this.results,
    this.next_offset,
  });

  InlineQueryResults.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_query_id = map['inline_query_id'];
    if (map['button'] != null) {
      button = TdApiMap.fromMap(map['button']) as InlineQueryResultsButton;
    }
    if (map['results'] != null) {
      results = [];
      for (var someValue in map['results']) {
        if (someValue != null) {
          results?.add(TdApiMap.fromMap(someValue) as InlineQueryResult);
        }
      }
    }
    next_offset = map['next_offset'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inline_query_id': inline_query_id?.toMap(skipNulls: skipNulls),
      'button': button?.toMap(skipNulls: skipNulls),
      'results': results?.toMap(skipNulls: skipNulls),
      'next_offset': next_offset?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

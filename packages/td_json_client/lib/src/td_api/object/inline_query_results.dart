import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/inline_query_result.dart';

/// Represents the results of the inline query. Use sendInlineQueryResultMessage to send the result of the query
class InlineQueryResults extends TdObject {
  String get tdType => 'inlineQueryResults';

  /// Unique identifier of the inline query
  int64? inline_query_id;

  /// The offset for the next request. If empty, there are no more results
  string? next_offset;

  /// Results of the query
  vector<InlineQueryResult>? results;

  /// If non-empty, this text must be shown on the button, which opens a private chat with the bot and sends the bot a start message with the switch_pm_parameter
  string? switch_pm_text;

  /// Parameter for the bot start message
  string? switch_pm_parameter;

  InlineQueryResults({
    super.extra,
    super.client_id,
    this.inline_query_id,
    this.next_offset,
    this.results,
    this.switch_pm_text,
    this.switch_pm_parameter,
  });

  InlineQueryResults.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_query_id = map['inline_query_id'];
    next_offset = map['next_offset'];
    if (map['results'] != null) {
      results = [];
      for (var someValue in map['results']) {
        if (someValue != null) {
          results?.add(TdApiMap.fromMap(someValue) as InlineQueryResult);
        }
      }
    }
    switch_pm_text = map['switch_pm_text'];
    switch_pm_parameter = map['switch_pm_parameter'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inline_query_id': inline_query_id?.toMap(skipNulls: skipNulls),
      'next_offset': next_offset?.toMap(skipNulls: skipNulls),
      'results': results?.toMap(skipNulls: skipNulls),
      'switch_pm_text': switch_pm_text?.toMap(skipNulls: skipNulls),
      'switch_pm_parameter': switch_pm_parameter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/inline_query_result.dart';

class InlineQueryResults extends TdObject {
  String get tdType => 'inlineQueryResults';

  String? extra;
  int? client_id;
  int64? inline_query_id;
  string? next_offset;
  vector<InlineQueryResult>? results;
  string? switch_pm_text;
  string? switch_pm_parameter;

  InlineQueryResults({
    this.extra,
    this.client_id,
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
    if (map['results']) {
      results = [];
      for (var someValue in map['results']) {
        results?.add(TdApiMap.fromMap(someValue) as InlineQueryResult);
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

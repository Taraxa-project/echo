import 'package:td_json_client/api/base.dart';


/// Answers a custom query; for bots only 
class AnswerCustomQuery extends TdFunction {
  String get tdType => 'answerCustomQuery';
  String get tdReturnType => 'Ok';


  /// Identifier of a custom query 
  int64? custom_query_id;

  /// JSON-serialized answer to the query
  string? data;

  AnswerCustomQuery({
    super.extra,
    super.client_id,
    this.custom_query_id,
    this.data,
  });

  AnswerCustomQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    custom_query_id = map['custom_query_id'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'custom_query_id': custom_query_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

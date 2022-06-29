import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_inline_query_result.dart';


/// Sets the result of interaction with a web app and sends corresponding message on behalf of the user to the chat from which the query originated; for bots only
class AnswerWebAppQuery extends TdFunction {
  String get tdType => 'answerWebAppQuery';
  String get tdReturnType => 'SentWebAppMessage';

  String? extra;
  int? client_id;

  /// Identifier of the web app query
  string? web_app_query_id;

  /// The result of the query
  InputInlineQueryResult? result;

  AnswerWebAppQuery({
    this.extra,
    this.client_id,
    this.web_app_query_id,
    this.result,
  });

  AnswerWebAppQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    web_app_query_id = map['web_app_query_id'];
    if (map['result'] != null) {
      result = TdApiMap.fromMap(map['result']) as InputInlineQueryResult;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'web_app_query_id': web_app_query_id?.toMap(skipNulls: skipNulls),
      'result': result?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

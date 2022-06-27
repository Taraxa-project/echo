import 'package:td_json_client/api/base.dart';

class AnswerPreCheckoutQuery extends TdFunction {
  String get tdType => 'answerPreCheckoutQuery';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int64? pre_checkout_query_id;
  string? error_message;

  AnswerPreCheckoutQuery({
    this.extra,
    this.client_id,
    this.pre_checkout_query_id,
    this.error_message,
  });

  AnswerPreCheckoutQuery.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    pre_checkout_query_id = map['pre_checkout_query_id'];
    error_message = map['error_message'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'pre_checkout_query_id': pre_checkout_query_id?.toMap(skipNulls: skipNulls),
      'error_message': error_message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

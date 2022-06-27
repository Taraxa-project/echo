import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/call_problem.dart';

class SendCallRating extends TdFunction {
  String get tdType => 'sendCallRating';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int32? call_id;
  int32? rating;
  string? comment;
  vector<CallProblem>? problems;

  SendCallRating({
    this.extra,
    this.client_id,
    this.call_id,
    this.rating,
    this.comment,
    this.problems,
  });

  SendCallRating.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call_id = map['call_id'];
    rating = map['rating'];
    comment = map['comment'];
    if (map['problems']) {
      problems = [];
      for (var someValue in map['problems']) {
        problems?.add(TdApiMap.fromMap(someValue) as CallProblem);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'call_id': call_id?.toMap(skipNulls: skipNulls),
      'rating': rating?.toMap(skipNulls: skipNulls),
      'comment': comment?.toMap(skipNulls: skipNulls),
      'problems': problems?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

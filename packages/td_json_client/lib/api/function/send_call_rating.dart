import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/call_problem.dart';


/// Sends a call rating
class SendCallRating extends TdFunction {
  String get tdType => 'sendCallRating';
  String get tdReturnType => 'Ok';


  /// Call identifier
  int32? call_id;

  /// Call rating; 1-5
  int32? rating;

  /// An optional user comment if the rating is less than 5
  string? comment;

  /// List of the exact types of problems with the call, specified by the user
  vector<CallProblem>? problems;

  SendCallRating({
    super.extra,
    super.client_id,
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
    if (map['problems'] != null) {
      problems = [];
      for (var someValue in map['problems']) {
        if (someValue != null) {
          problems?.add(TdApiMap.fromMap(someValue) as CallProblem);
        }
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

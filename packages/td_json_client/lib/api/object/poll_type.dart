import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';

abstract class PollType extends TdObject {}

class PollTypeRegular extends PollType {
  String get tdType => 'pollTypeRegular';

  string? extra;
  int? client_id;
  Bool? allow_multiple_answers;

  PollTypeRegular({
    this.extra,
    this.client_id,
    this.allow_multiple_answers,
  });

  PollTypeRegular.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    allow_multiple_answers = map['allow_multiple_answers'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'allow_multiple_answers': allow_multiple_answers?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class PollTypeQuiz extends PollType {
  String get tdType => 'pollTypeQuiz';

  string? extra;
  int? client_id;
  int32? correct_option_id;
  FormattedText? explanation;

  PollTypeQuiz({
    this.extra,
    this.client_id,
    this.correct_option_id,
    this.explanation,
  });

  PollTypeQuiz.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    correct_option_id = map['correct_option_id'];
    explanation = TdApiMap.fromMap(map['explanation']) as FormattedText;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'correct_option_id': correct_option_id?.toMap(skipNulls: skipNulls),
      'explanation': explanation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

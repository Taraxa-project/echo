import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';

/// Describes the type of a poll
abstract class PollType extends TdObject {}


/// A regular poll 
class PollTypeRegular extends PollType {
  String get tdType => 'pollTypeRegular';

  String? extra;
  int? client_id;

  /// True, if multiple answer options can be chosen simultaneously
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

/// A poll in quiz mode, which has exactly one correct answer option and can be answered only once
class PollTypeQuiz extends PollType {
  String get tdType => 'pollTypeQuiz';

  String? extra;
  int? client_id;

  /// 0-based identifier of the correct answer option; -1 for a yet unanswered poll
  int32? correct_option_id;

  /// Text that is shown when the user chooses an incorrect answer or taps on the lamp icon; 0-200 characters with at most 2 line feeds; empty for a yet unanswered poll
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
    if (map['explanation'] != null) {
      explanation = TdApiMap.fromMap(map['explanation']) as FormattedText;
    }
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

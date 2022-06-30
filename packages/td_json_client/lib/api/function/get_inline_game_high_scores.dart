import 'package:td_json_client/api/base.dart';


/// Returns game high scores and some part of the high score table in the range of the specified user; for bots only 
class GetInlineGameHighScores extends TdFunction {
  String get tdType => 'getInlineGameHighScores';
  String get tdReturnType => 'GameHighScores';


  /// Inline message identifier 
  string? inline_message_id;

  /// User identifier
  int53? user_id;

  GetInlineGameHighScores({
    super.extra,
    super.client_id,
    this.inline_message_id,
    this.user_id,
  });

  GetInlineGameHighScores.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_message_id = map['inline_message_id'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inline_message_id': inline_message_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/game_high_score.dart';

class GameHighScores extends TdObject {
  String get tdType => 'gameHighScores';

  string? extra;
  int? client_id;
  vector<GameHighScore>? scores;

  GameHighScores({
    this.extra,
    this.client_id,
    this.scores,
  });

  GameHighScores.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['scores']) {
      scores = [];
      for (var someValue in map['scores']) {
        scores?.add(TdApiMap.fromMap(someValue) as GameHighScore);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'scores': scores?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

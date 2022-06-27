import 'package:td_json_client/api/base.dart';

class GameHighScore extends TdObject {
  String get tdType => 'gameHighScore';

  string? extra;
  int? client_id;
  int32? position;
  int53? user_id;
  int32? score;

  GameHighScore({
    this.extra,
    this.client_id,
    this.position,
    this.user_id,
    this.score,
  });

  GameHighScore.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    position = map['position'];
    user_id = map['user_id'];
    score = map['score'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'position': position?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'score': score?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

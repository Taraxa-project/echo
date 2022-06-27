import 'package:td_json_client/api/base.dart';

class SetInlineGameScore extends TdFunction {
  String get tdType => 'setInlineGameScore';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  string? inline_message_id;
  Bool? edit_message;
  int53? user_id;
  int32? score;
  Bool? force;

  SetInlineGameScore({
    this.extra,
    this.client_id,
    this.inline_message_id,
    this.edit_message,
    this.user_id,
    this.score,
    this.force,
  });

  SetInlineGameScore.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_message_id = map['inline_message_id'];
    edit_message = map['edit_message'];
    user_id = map['user_id'];
    score = map['score'];
    force = map['force'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inline_message_id': inline_message_id?.toMap(skipNulls: skipNulls),
      'edit_message': edit_message?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'score': score?.toMap(skipNulls: skipNulls),
      'force': force?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

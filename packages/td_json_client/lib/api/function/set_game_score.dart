import 'package:td_json_client/api/base.dart';

class SetGameScore extends TdFunction {
  String get tdType => 'setGameScore';
  String get tdReturnType => 'Message';

  String? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  Bool? edit_message;
  int53? user_id;
  int32? score;
  Bool? force;

  SetGameScore({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.edit_message,
    this.user_id,
    this.score,
    this.force,
  });

  SetGameScore.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
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
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
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

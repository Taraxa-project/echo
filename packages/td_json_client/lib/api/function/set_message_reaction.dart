import 'package:td_json_client/api/base.dart';

class SetMessageReaction extends TdFunction {
  String get tdType => 'setMessageReaction';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  string? reaction;
  Bool? is_big;

  SetMessageReaction({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.reaction,
    this.is_big,
  });

  SetMessageReaction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    reaction = map['reaction'];
    is_big = map['is_big'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'reaction': reaction?.toMap(skipNulls: skipNulls),
      'is_big': is_big?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

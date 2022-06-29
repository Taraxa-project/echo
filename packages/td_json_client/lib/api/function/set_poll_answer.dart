import 'package:td_json_client/api/base.dart';


/// Changes the user answer to a poll. A poll in quiz mode can be answered only once
class SetPollAnswer extends TdFunction {
  String get tdType => 'setPollAnswer';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Identifier of the chat to which the poll belongs 
  int53? chat_id;

  /// Identifier of the message containing the poll
  int53? message_id;

  /// 0-based identifiers of answer options, chosen by the user. User can choose more than 1 answer option only is the poll allows multiple answers
  vector<int32>? option_ids;

  SetPollAnswer({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.option_ids,
  });

  SetPollAnswer.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['option_ids'] != null) {
      option_ids = [];
      for (var someValue in map['option_ids']) {
        option_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'option_ids': option_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

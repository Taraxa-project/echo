import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reply_markup.dart';


/// Stops a poll. A poll in a message can be stopped when the message has can_be_edited flag set
class StopPoll extends TdFunction {
  String get tdType => 'stopPoll';
  String get tdReturnType => 'Ok';


  /// Identifier of the chat to which the poll belongs
  int53? chat_id;

  /// Identifier of the message containing the poll
  int53? message_id;

  /// The new message reply markup; pass null if none; for bots only
  ReplyMarkup? reply_markup;

  StopPoll({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.reply_markup,
  });

  StopPoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

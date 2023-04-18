import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/reply_markup.dart';

/// Edits the message reply markup; for bots only. Returns the edited message after the edit is completed on the server side
class EditMessageReplyMarkup extends TdFunction {
  String get tdType => 'editMessageReplyMarkup';
  String get tdReturnType => 'Message';

  /// The chat the message belongs to
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  /// The new message reply markup; pass null if none
  ReplyMarkup? reply_markup;

  EditMessageReplyMarkup({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.reply_markup,
  });

  EditMessageReplyMarkup.fromMap(Map<String, dynamic> map) {
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
